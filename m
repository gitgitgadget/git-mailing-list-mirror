From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] git-send-email: Validate recipient_cmd (to-cmd,
 cc-cmd) addresses
Date: Thu, 21 Apr 2011 00:50:51 +0200
Message-ID: <BANLkTintK1KgPWX7ycMQtVBnKi+tVj7k2Q@mail.gmail.com>
References: <BANLkTikdaSG_jbzaJ7UCpG5JnwneARfx3Q@mail.gmail.com>
	<20110419215239.GA22632@elie>
	<1303268630.24766.9.camel@Joe-Laptop>
	<BANLkTinfbF3xyfrdgfmgHQF7RHCHk8ardw@mail.gmail.com>
	<1303336253.24766.34.camel@Joe-Laptop>
	<BANLkTikuC1V1U-c0wyThOZAn6gVXr7S_cQ@mail.gmail.com>
	<1303339511.24766.41.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 00:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCgEc-00046H-Fi
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 00:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420Ab1DTWux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 18:50:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46211 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1DTWux convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 18:50:53 -0400
Received: by fxm17 with SMTP id 17so669532fxm.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w14xkyIT98ccwLpq0H7CWcprIRANASihx0gXvYWOVkw=;
        b=T3POVbsf/sMtivQbsVL78EOG16O0ele2V/r0HXuV+qYJe/8OVT+BBmxuym+OrhD6sB
         1tZJ5mrydEzON7LDkrCw/HmQzKqQU4c2vedvLa6jio0y3WDToF1DKMfof2c1Kk72a++M
         AMNDR9iUrEdj3KVuKq3gTKk4FBmYEeKFhvPvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bK+etUFkIOZElvWBEAPhzaZVusrvbmDrzG9XhCFjxA+nS6LkwuCTDltTT8asdB552M
         x+GILVxqhYstCnSFOeKMRL8IUu/28vrZJpBPlyxFhn8nbYk4hYIG5SyiXUVUAsTEiqcs
         2imB7iw1tM+fJg6v4Z33fuoQ0COSGheuPNYC4=
Received: by 10.223.24.72 with SMTP id u8mr2639742fab.10.1303339851828; Wed,
 20 Apr 2011 15:50:51 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Wed, 20 Apr 2011 15:50:51 -0700 (PDT)
In-Reply-To: <1303339511.24766.41.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171879>

On Thu, Apr 21, 2011 at 00:45, Joe Perches <joe@perches.com> wrote:
> On Thu, 2011-04-21 at 00:29 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason wrote:
>> On Wed, Apr 20, 2011 at 23:50, Joe Perches <joe@perches.com> wrote:
>> > + =C2=A0 =C2=A0 =C2=A0 my ($recipient_name, $recipient_addr) =3D (=
$recipient =3D~ /^\s*(.*?)\s*(<[^>]+>)/);
>> In Perl you can write (<.*?>) instead of (<[^>]+>)
>
> Hey =C3=86var. =C2=A0That matches <>. =C2=A0Not a good email address.

True, but you can use <.+?> instead.

I meant that you don't need to work around the lack of non-greedy
regex features in Perl.
