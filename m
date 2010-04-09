From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] ls-remote: fall-back to default remotes when no remote 
	specified
Date: Fri, 9 Apr 2010 17:15:51 +0800
Message-ID: <g2ube6fef0d1004090215uefd96052w64de7233c26002ae@mail.gmail.com>
References: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
	 <1270747273-1504-1-git-send-email-rctay89@gmail.com>
	 <A612847CFE53224C91B23E3A5B48BAC7448206860D@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 11:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0APz-0000Jl-38
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 11:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103Ab0DIJWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 05:22:23 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:49605 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991Ab0DIJWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 05:22:22 -0400
Received: by yxe1 with SMTP id 1so1343755yxe.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ik3aji/MhLXVtDrdnfoR/1xc7aKlVuH3dBJhzJi7IlM=;
        b=Q8VF/naPJlzHUuUwfdOGP1Rh0ZLCxDkS/wJ368/8L+WFee0TDK5FMt3oKiuq3om5vP
         uSnfUV6QqwiJOHx7TUqmA7bzySY8vRdy572crPT1uYiEVOjxd4vBSRxSMzy074WW3iUX
         ZkYUVEbS8jzbz1Cax3b3rcNzQBkCjASqgD8Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U+kymdoQslj/Eg8ld2+wLq2pe+9fwu9eAWlfe0TzGoCojBmuzm+z9F1W6M7htdkO0+
         Z6ubxek/RI+23+xhNe4j8SueukwrD4xbD6potT+Sj0TrvsVX/8oYXp3+KWR5T6cKbeLj
         VeO0N9sTWxQclUtxuAg68dnXu+71oUkh4Vi0k=
Received: by 10.231.10.65 with HTTP; Fri, 9 Apr 2010 02:15:51 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC7448206860D@xmail3.se.axis.com>
Received: by 10.101.176.33 with SMTP id d33mr2418244anp.49.1270804551317; Fri, 
	09 Apr 2010 02:15:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144420>

Hi,

On Fri, Apr 9, 2010 at 4:49 PM, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] O=
n
>> Behalf Of Tay Ray Chuan
>> =A0static const char ls_remote_usage[] =3D
>> -"git ls-remote [--heads] [--tags] =A0[-u <exec> | --upload-pack <ex=
ec>] <repository> <refs>...";
>> + =A0 =A0 =A0 "git ls-remote [--heads] [--tags] =A0[-u <exec> | --up=
load-pack <exec>]\n"
>> +" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [<repository> [<refs>...]=
]";
>
> That should be:
>
> static const char ls_remote_usage[] =3D
> =A0 =A0 =A0 =A0"git ls-remote [--heads] [--tags] =A0[-u <exec> | --up=
load-pack <exec>]\n"
> =A0 =A0 =A0 =A0" =A0 =A0 =A0 =A0 =A0 =A0 =A0[<repository> [<refs>...]=
]";
>
> or the second line of the usage will not be indented as intended.

Nope, you are not right - you didn't take into account the "usage: "
string that is prepended. (The non-printed whitespace in front of "git
ls-remote..." is equivalent to that string.)

--=20
Cheers,
Ray Chuan
