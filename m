From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/12] git submodule update: Announce skipping submodules
 on stderr
Date: Fri, 16 Oct 2015 13:47:13 -0700
Message-ID: <CAGZ79kZH1sdboAzFCjAUKtg0sJcPZGjzVrHPa_r8dG4bK4uT-w@mail.gmail.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
	<1444960333-16003-2-git-send-email-sbeller@google.com>
	<xmqqbnbyeei6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:47:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBuJ-0007S7-SJ
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbbJPUrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:47:15 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34588 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbJPUrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:47:14 -0400
Received: by ykfy204 with SMTP id y204so96244607ykf.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yyvjmTRC1g70TuJjhM/SYI/jCnlMS2WRnWgoIa88LOg=;
        b=J3LcoDxXhQPB5Bu8+zcRRbhpiMZfRm35thCtLEsM3+syqsM4Z++tno65JzHgKNr3W6
         WRkLV28kp13ULq4a/O2p+50TrVcQPAiqA9CimJNOw4OtzjZGPiVlf7j/dD10l4kBuybR
         10Jnyt8Bh3scuyfzFxHyZ7AptAiSYhHz00u5sqG8hsSOU6iswQ5BlwQFzjGP4qBGhdku
         9GT1Zg6XOAn7LNOnlNMojUImlvmFnyzxi3rfs1khIzGtPmqDXxPlczueYxWNEqgJIpiB
         GRA2dg0hUguSYSuCgdQYmNkQ5slFmWA9R1L2f4HBNUDbYTdrfDAQenfNHXTWC9U5ACt2
         8XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yyvjmTRC1g70TuJjhM/SYI/jCnlMS2WRnWgoIa88LOg=;
        b=hGicEEpPYABZdqgmCfILeAxd9U45ybhBcvpbLKfXsu8ZK5EC+m66hUU7IhDipvDlGe
         cDu3PE2VSaZBYWsUWGm1aWfBlo+r3a7bVNl3+owk2SVXwR5lHx6rMA4Up6bfxiGezR+B
         1/Ms0zaG9AGYws9cfBpSBDSlbngxMH48EqZn70hin0YF9dIDpCMZ+O5yA4+Dg0PZRFRN
         4vr9wq4lNFvrfVZZPd+etP2FNjy1jyf3trf9wKGIh0bec8cPwlkufVi3xnnxZiP4CMF8
         Otx3Ddc7/IlkzagZTe/rQTQEj5x0gnU/nNoKkhz6+qQIDb7ShmUoGC8+TkpVh+H5gi6a
         YLrw==
X-Gm-Message-State: ALoCoQnoCpqd8sKZ84xp3BsSuYBGe8B8CDTpzO42+M+KDsbJRQKhlM87n1uuv4D37L7vSxQjWr6J
X-Received: by 10.129.91.68 with SMTP id p65mr11536506ywb.252.1445028433639;
 Fri, 16 Oct 2015 13:47:13 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 16 Oct 2015 13:47:13 -0700 (PDT)
In-Reply-To: <xmqqbnbyeei6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279767>

On Fri, Oct 16, 2015 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 8b0eb9a..578ec48 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -684,7 +684,7 @@ cmd_update()
>>
>>               if test "$update_module" = "none"
>>               then
>> -                     echo "Skipping submodule '$displaypath'"
>> +                     echo >&2 "Skipping submodule '$displaypath'"
>>                       continue
>>               fi
>
> Makes sense, but see 02/12.

The patch (I can't see a reply there) ?

I split them on purpose. This one uses echo as opposed to say and has
no tests to fail.

So this patch documents, that there are no breaking tests. I can just change it
2/12 tells another story: We codified the behavior in tests and rely on it, so
we need to carefully decide if that's a breaking change.



>
