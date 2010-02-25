From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [RFC/PATCH] notes: rework subcommands and parse options
Date: Thu, 25 Feb 2010 13:26:19 -0500
Message-ID: <32c343771002251026n6d55ea7csbdb4c8899bb5fded@mail.gmail.com>
References: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 19:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkiPu-0005yB-Ea
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 19:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281Ab0BYS0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 13:26:25 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:38580 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234Ab0BYS0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 13:26:23 -0500
Received: by ey-out-2122.google.com with SMTP id 25so131845eya.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VdsTJmBzwqTlxDRUCbf+TUy9+EUsaWCClZ0cJmfWmb4=;
        b=Ro9DJAtdl6orRvJqB2L3S9OYh+sj77l53YiD3PZg0zDpgWM5+3EaJGjw2X7IE1CK84
         FHrG4OjrBcTPryARWBkb50rcXhcauIsLYNeA896pQL7a6lhhiFFuRmByD7akCtI88V+S
         HkCdw4Peyv8nOCJAtPbH0d+axWlswajn7rDwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kamz5KOcpwB+ObIANTrajAliXiR/zC1nytzEAGGdlf7iITHjeQKJEpirtupdh15P9/
         8/GbZfTG62eOzaOekhgXXL6rX1uQembIA5C80n+eQNKPGFxzR8ei/8E/1ZZ2QJ0GHE86
         1afTAMPdLcqJfzJ2zOkz8PEQzSErf6mOJGU9M=
Received: by 10.216.89.12 with SMTP id b12mr959306wef.93.1267122379755; Thu, 
	25 Feb 2010 10:26:19 -0800 (PST)
In-Reply-To: <1267086261-7675-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141062>

On Thu, Feb 25, 2010 at 3:24 AM, Stephen Boyd <bebarino@gmail.com> wrot=
e:
>
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D error("=
Unknown subcommand: %s", argv[0]);
> + =C2=A0 =C2=A0 =C2=A0 }

In the case where an unknown subcommand was given, shouldn't the usage
instructions be printed?  i.e. add the following after the error()?

    usage_with_options(git_notes_usage, options);

-Tim
