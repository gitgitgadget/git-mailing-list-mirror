From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git-svn error: ambiguous argument
Date: Mon, 28 Jun 2010 08:03:01 +0200
Message-ID: <AANLkTikKdDI_NMzvsA7e_VoYo7Ie97e2pBkZe_0xPt9P@mail.gmail.com>
References: <7A6370FC-843B-43FD-8064-4F44C9C66493@inuus.com>
	<AANLkTik_YK6_KbRIq4MsrU-LDn8apHQfm1_f7XHKKfX1@mail.gmail.com>
	<AANLkTil7WdGZTtmwwK0kYPkK6-y4W5HKKLNdtkoI0riM@mail.gmail.com>
	<AANLkTimE6Wo9HT0p5WMfTggJ059dhDg4fyPeax93VCLy@mail.gmail.com>
	<0D702391-E490-4942-AAB6-C8C887E671C5@inuus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Lindner <lindner@inuus.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 08:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT7R9-0001JZ-Al
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 08:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab0F1GDN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 02:03:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41850 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab0F1GDC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 02:03:02 -0400
Received: by iwn7 with SMTP id 7so818840iwn.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qvn5A+ux4jSR5Q1ZZlLswLXkUaIBFZxZfUrpnUIqpBU=;
        b=uIU93JOkkcwVdhydpjNyQn66K2nSD0tEx/MtEYBEDeDspVsSaXLkXoN4WvVRyZVwAM
         jG8cxL9MKDsov2I6Me5VMeQS/DVyUeIRAw4apcQvesTJTH/8BCIVS2cKclOKGnanPucY
         CE6wJtDd/kEwpm5Z2IW/E7XF/8UCuP8/Y/Kc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XHcipOefs1gcLnbVIkkzNAc+BiFBXXlf/WRhmY67/ew1Un+yQ29+0yLa3y7R1CU9lS
         TkI7CqKvcPd3Rqr0AwFAbLJoqYtWK1GTrCMS1QglYMUpmhlHWW6nZlwTYo3LsArLfIt6
         jRUdXDIOPgkol6o5HmAiJvFvX9n6YgMV8gFDc=
Received: by 10.231.148.130 with SMTP id p2mr4470641ibv.11.1277704981649; Sun, 
	27 Jun 2010 23:03:01 -0700 (PDT)
Received: by 10.231.34.198 with HTTP; Sun, 27 Jun 2010 23:03:01 -0700 (PDT)
In-Reply-To: <0D702391-E490-4942-AAB6-C8C887E671C5@inuus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149811>

On Tue, May 11, 2010 at 21:44, Paul Lindner <lindner@inuus.com> wrote:
> This fixed it for my situation. =C2=A0Thanks!
>
> On May 11, 2010, at 9:20 AM, Bert Wesarg wrote:
>
>>
>> Can you try this patch, it worked on my site:
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index b3b6964..40ecec0 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3103,7 +3095,11 @@ sub check_cherry_pick {
>> =C2=A0 =C2=A0 =C2=A0 my %commits =3D map { $_ =3D> 1 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _rev_list("--no-mer=
ges", $tip, "--not", $base);
>> =C2=A0 =C2=A0 =C2=A0 for my $range ( @ranges ) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 delete @commits{_rev_lis=
t($range)};
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( $range =3D~ /^([[:x=
digit:]]{40})\^\.\.([[:xdigit:]]{40})$/i ) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 delete @commits{_rev_list(sprintf("%s^!", $1), $2)};
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 delete @commits{_rev_list($range)};
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 for my $commit (keys %commits) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_no_changes(=
$commit)) {

Eric, have you picked this up, or should I re-send it as a propper patc=
h?

Bert
