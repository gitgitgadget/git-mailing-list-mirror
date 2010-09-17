From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 4/7] gitweb: link heads and remotes view
Date: Fri, 17 Sep 2010 18:01:18 +0200
Message-ID: <AANLkTi=vB-aoEnajR_Lif1XO7+4zgq3HK6he6umk=svJ@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-5-git-send-email-giuseppe.bilotta@gmail.com> <201009170102.23053.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdNh-0001Rv-0y
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0IQQBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 12:01:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58734 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab0IQQBj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 12:01:39 -0400
Received: by pvg2 with SMTP id 2so635727pvg.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GpNTWRZ6vgNNu/jyQ2qeoWlI2zkanwCqw3tVNA3cbFc=;
        b=CvF8wl4YU355TrYxdlAFU83exAFFQTtMSUpj7ZU7xRGZV/iSwKHaXZEvznpZ0Sjzvh
         2Y276on2m9Nl51laj7851/9NTt1te4ZfS3jKgN43n159MO5ZiqYbCJCbF53fWQ5XzDXW
         ALgoSR4sDvyp9mXNTsVys+ZywYV5l9obkzaCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HsG1bt3Rp1qT1dXajphY3jzMWTpuNMWWi5/ZO2np5QPG/GoLsXm6bsWcO+4sPPqeD9
         NaZ4KXi7e3mZylngp7RZiq84336n2lT5PBqBvWVTWa7654OS/Y8v2R7BPGZSUfznUrkl
         JAiu8y5MKefxmYm++dumlMlYDM0VjVSH+xMyQ=
Received: by 10.143.86.9 with SMTP id o9mr4354887wfl.177.1284739298488; Fri,
 17 Sep 2010 09:01:38 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 09:01:18 -0700 (PDT)
In-Reply-To: <201009170102.23053.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156391>

2010/9/17 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>
>> Add a link in heads view to remotes view (if the feature is
>> enabled), and conversely from remotes to heads.
>
> Good idea... but this commit message doesn't tell us *where* this lin=
k
> do appear. =A0It is in lower part (the action specific part) of page
> navigation menu.

I will clarify it in the next rehash of this patchset.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0gitweb/gitweb.perl | =A0 10 ++++++++--
>> =A01 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 0118739..6138c6e 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -5511,7 +5511,10 @@ sub git_tags {
>> =A0sub git_heads {
>> =A0 =A0 =A0 my $head =3D git_get_head_hash($project);
>> =A0 =A0 =A0 git_header_html();
>> - =A0 =A0 git_print_page_nav('','', $head,undef,$head);
>> + =A0 =A0 my $heads_nav =3D gitweb_check_feature('remote_heads') ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href =3D> href(action=3D>"remote=
s", -replay=3D>1)},
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "remotes") : undef;
>
> I think it would be more readable here to use 'if' statement instead
> of conditional operator.

You're right. I'm actually thinking about putting 'tags' in that nav
menu too, as it makes sense to link to all refs commands there.

--=20
Giuseppe "Oblomov" Bilotta
