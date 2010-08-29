From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 02/13] fast-export: support done feature
Date: Sun, 29 Aug 2010 15:25:05 -0500
Message-ID: <AANLkTikeWG=PpR4knWAYuKfO7g4Edm5+a2_rR4VwSTeU@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-3-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1008291500070.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoRX-0008WJ-6V
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0H2UZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:25:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52749 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab0H2UZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:25:26 -0400
Received: by yxp4 with SMTP id 4so60948yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qjLOQzRek7A4QXX4hzsLYg83xozUMMvNvpkIzYGnvxU=;
        b=aofcMiTsncw9sh9onNR6/RXIFgtF1y3Fb1GZxxr0zn+3RTuNjOM06J6KsMSm4h6cqk
         8lGKVDPWE+XtskHkiestHrIiYAPDsfDMopza8LTgdS9JTVU7RXcI2AuoF32+8RZUB5Nu
         Pp7BR7mjhFtDCmour7GQjN/q7RRo9WTOURsUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xTwmGDNn7PU0SfLqZbfxUZhlbxqi2cM2LH4i3hFY04tBKkdyD/NxqqpCflXEDQbziI
         n95+wR+3dwpkkL5Dp4JpVYPj/dx4qZBo7MtpjOGVQcredtt6dVPDTzLxgs0jzJox6iBW
         ctYvnRxld1PHCLRGjArJJZUycwwyjNHPs0MsY=
Received: by 10.150.53.21 with SMTP id b21mr4299999yba.353.1283113525167; Sun,
 29 Aug 2010 13:25:25 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 13:25:05 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008291500070.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154711>

Heya,

On Sun, Aug 29, 2010 at 14:15, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I was assuming that whatever passed the output from fast-export to
> fast-import would add the "done" itself when its fast-export child
> exitted.

I tried this, but it results in some unelegant code where you have to
make sure to flush before starting the exporter, etc. I thought in
general it was better to make one program responsible for the entire
stream.

-- 
Cheers,

Sverre Rabbelier
