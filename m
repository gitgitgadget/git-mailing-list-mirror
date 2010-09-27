From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 06/12] gitweb: allow extra text after action in page header
Date: Mon, 27 Sep 2010 09:42:13 +0200
Message-ID: <201009270942.14731.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <201009262011.28211.jnareb@gmail.com> <AANLkTinpZ5gusCG4SoKbi54URyn7T4THNp2NeVM6uFL2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:42:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08M4-0002km-C9
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab0I0Hm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:42:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab0I0Hm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 03:42:26 -0400
Received: by fxm3 with SMTP id 3so1623593fxm.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=o+MBjHPSvwp0pZypbc7/NEHAS08mTme3ugMIggAMCmM=;
        b=ekv7pc8UprLGa6hGKW33jVTXw6ptEdA75cGiijv2sISVJ2rX9YE0zsnrbHo58H8n9z
         TbjzqAYEiKOBizeBNxcJgdM6yZThlKp1CGk0fChi2n205K2XLxifIG+h9D1p7Rcb/ueu
         /RJIWCX8T5JT4yL2n6NCusqedvsmzxlMbIdr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YYcMhAEp1aHh/o1209lMeBJaXNgc5ozLLj9OEh7VBsCKG8mENuncbVIC3XYmnmTv20
         407+g/NIouS7jBk1MO+qYspyEw8wW026o2tg4owjgekwrKXr16VKIa4DsZkgRBywChqM
         y0nckDFusg7DTBZupM24hCKDSdonZW/Hqi0qY=
Received: by 10.223.163.80 with SMTP id z16mr1086308fax.62.1285573344606;
        Mon, 27 Sep 2010 00:42:24 -0700 (PDT)
Received: from [192.168.1.13] (abvz242.neoplus.adsl.tpnet.pl [83.8.223.242])
        by mx.google.com with ESMTPS id 10sm2237950fax.18.2010.09.27.00.42.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 00:42:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinpZ5gusCG4SoKbi54URyn7T4THNp2NeVM6uFL2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157315>

On Mon, 27 Sep 2010, Giuseppe Bilotta wrote:
> 2010/9/26 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index e70897e..76cf806 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -3514,7 +3514,15 @@ EOF
>>> =A0 =A0 =A0 if (defined $project) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print $cgi->a({-href =3D> href(action=3D=
>"summary")}, esc_html($project));
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $action) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $action";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $action_print =3D $act=
ion ;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{'header=
_extra'}) {
[...]

>> I also think that we can think of better name for this option than
>> 'header_extra', although what this name could be eludes me.
>=20
> I will add the dash to the option. Naming it header_extra keeps the
> meaning of this extra text generic, but considering that the intended
> use is mostly for the single-remote view (or similar, if/when they ar=
e
> added) we could call it something related (I can only think of
> 'main_argument' right now but I think this would suck more than
> header_extra).

Perhaps name this argument '-subaction' or '-action_argument', or
something like that; the meaning of this argument (as shown by the fact
that action name is hyperlinked) is to specify subaction of given actio=
n,
i.e. (possibly) more detailed view of some part of generic (argument-le=
ss)
action output.
=20
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $action_print";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (defined $opts{'header_extra'}) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print " / $opts{'header_e=
xtra'}";
>>
>> Hmmm...
>=20
> You don't sound very convinced. I had some doubts myself about whethe=
r
> the slash should be inserted autmatically or whether it should be up
> to the caller to include it in header_extra, but I'm not sure this is
> what you are perplexed about.

Ah, I'm sorry, I have misunderstood the control flow here.  I see now
that it is about adding subaction specifier after action, so that
'remotes' view for single remote 'origin' (<URL>/remotes/origin path_in=
fo
URL, see comments for patch introducing single-remote view) has

  _projects_ / _repo.git_ / _remotes_ / origin

in the "breadcrumbs" navigation in page header.

This should be better described in the commit message.
--=20
Jakub Narebski
Poland
