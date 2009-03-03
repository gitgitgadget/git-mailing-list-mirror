From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3] send-email: add --confirm option and configuration 
	setting
Date: Tue, 3 Mar 2009 11:22:53 -0500
Message-ID: <76718490903030822j690cb97blea292d391c0d0112@mail.gmail.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
	 <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
	 <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:24:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXPt-0003k0-1T
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZCCQW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbZCCQW4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:22:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:63571 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbZCCQWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:22:55 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2859366rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6PQRqBNZVcqWlXNWoW3GonNgl5e/Div2+v6Jf/K/szE=;
        b=jbCbSgPjfLAP/VWBvH7yjJ0VppNgEbe1oDvwDSJZiIbP+LCqLoE9ZZ01inO+5IWHc2
         6ke5ru9misZgZzXkxGIAw04EJu1+5FHK8CDV1Ith29jtwHssYIJ+fnry3ITmCgw9fbPN
         Oxi79VdkVaXg4LAqykmWfVVDoxGmJrp0ua8oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xF6jHjVscV+6BLLQYG25uJXe6S8HVhOK2s7pCi1eqgK03haKg0kizw866tdnp0H4wW
         UwXjnG5NAKqyysx4PWpF/aJkUuC4Mf3XP9gFmxcw6HgSWSAsD7G1vfzh59g01D9QIsVj
         A3uoCzLWt5cmwlk+wu1S6CzLuszAlL7cywGjU=
Received: by 10.140.139.4 with SMTP id m4mr3599159rvd.292.1236097373549; Tue, 
	03 Mar 2009 08:22:53 -0800 (PST)
In-Reply-To: <36ca99e90903030354j33de0313n41d8a95ff898798b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112108>

On Tue, Mar 3, 2009 at 6:54 AM, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
> On Tue, Mar 3, 2009 at 05:52, Jay Soffian <jaysoffian@gmail.com> wrot=
e:
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index adf7ecb..57127aa 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -837,6 +837,37 @@ X-Mailer: git-send-email $gitversion
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unshift (@sendmail_parameters,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0'-f', $raw_from) if(defined $envelope_sender);
>>
>> + =C2=A0 =C2=A0 =C2=A0 if ($needs_confirm && !$dry_run) {
> So, the output is now differnt with and without --dry-run?

There doesn't seem to be any point in having the user confirm before
sending the message if the message is not actually going to be sent.
Am I missing something?

j.
