From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] git-send-email: Validate recipient_cmd (to-cmd,
 cc-cmd) addresses
Date: Thu, 21 Apr 2011 00:29:24 +0200
Message-ID: <BANLkTikuC1V1U-c0wyThOZAn6gVXr7S_cQ@mail.gmail.com>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	<20110419215239.GA22632@elie>
	<1303268630.24766.9.camel@Joe-Laptop>
	<BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
	<1303336253.24766.34.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 00:29:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCftz-0000BP-89
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 00:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab1DTW30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 18:29:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47424 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1DTW3Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 18:29:25 -0400
Received: by fxm17 with SMTP id 17so661493fxm.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aRExWnCIgTvcA6DE9cb5ZPwWMWkuWDX+BYegm3Yb3rM=;
        b=YrqFinePfjMqVv85APNcZ4Axh3Npm0cE3HbQcAq1qKtA6yu41nxBKXEfJ7LSSq82PG
         KuLJtYgE7dm036yUveoSKl18OzBf3Hq9qEvrsvWol8Zt2TJqFByUc0NgxMPOea27b2Gc
         yI6yH5lXTwpko1cV2JLeJUJEumlUBNU0u5AF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eDRuMjjZlShIhas24y14tiqh/1GonyANFOsib5ZJkad+YbmVP2fYGMNdpqQsAofsG4
         V5bQmTWxzTX9ElHZDCpou4SflSFuLzUVcSrOVmXVU3JrvvhHIRegi14bvaIex1R4xszi
         E4eQkQbscJI6fwxZ1i7L9iIbzndevF2T8lxBc=
Received: by 10.223.54.219 with SMTP id r27mr2623824fag.124.1303338564626;
 Wed, 20 Apr 2011 15:29:24 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Wed, 20 Apr 2011 15:29:24 -0700 (PDT)
In-Reply-To: <1303336253.24766.34.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171877>

On Wed, Apr 20, 2011 at 23:50, Joe Perches <joe@perches.com> wrote:
> + =C2=A0 =C2=A0 =C2=A0 my ($recipient_name, $recipient_addr) =3D ($re=
cipient =3D~ /^\s*(.*?)\s*(<[^>]+>)/);

In Perl you can write (<.*?>) instead of (<[^>]+>)

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($recipient =3D=
~ /^\s*(.+\@\S*).*$/) {

If this program doesn't have some extract_emails_from_string()
function already it probably should.
