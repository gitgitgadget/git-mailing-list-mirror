From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 05/12] MINGW: git-compat-util.h: use inttypes.h for printf macros.
Date: Mon, 28 Apr 2014 17:07:34 +0200
Message-ID: <CABPQNSawLpFQGuW-WV-e=v1U1OQ2BeZcatyBfbb4Xv6C3TvD_Q@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-6-git-send-email-marat@slonopotamus.org>
 <CABPQNSaP=q5Y4oKOM3zAMvhATZx2BDj_8s6ZO1EBFPGrtSj1Tw@mail.gmail.com> <20140428150057.GA19002@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:08:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenAL-0001a0-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbaD1PIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:08:16 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59849 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbaD1PIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:08:14 -0400
Received: by mail-ie0-f177.google.com with SMTP id rp18so1343147iec.36
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=n39f03JcUsDZlXFOmH/SNqIsMVQ4BVMGOeScF5aCeM8=;
        b=sBEO+9nDnDCu5INtKHXHnsxNDVzdSxSpQs9Z5OA4Z7UFVFw5AK5k5fFXu6kq5ifVaM
         ZRgMzBw83Ii+b4hl/OjP2/IOfhhaXlaA5LDseSzzUeVcBzWtJaxbXLNVRjjuXRobc83Y
         OlkHHdJxF6cUKHLnGqZNEpsap4xg/E9Yl2aBHtoqV0Y3Beb93jZhlDF+jGDK3/qyqDAc
         tXjeiSPhe7eEACgGp1BlPTy4omNOR3ePDdASNxMINZFliV9X6BmIkGYfJ1pSMcdT8eOQ
         F+LJMEMcW9qpfH/y55HosfchkPaKxClGHuV8sM1bTqvTDkJBRtNFSnD89NaWVTX2aThU
         HTxg==
X-Received: by 10.42.204.197 with SMTP id fn5mr1268699icb.95.1398697694295;
 Mon, 28 Apr 2014 08:08:14 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:07:34 -0700 (PDT)
In-Reply-To: <20140428150057.GA19002@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247354>

On Mon, Apr 28, 2014 at 5:00 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 04:53:52PM +0200, Erik Faye-Lund wrote:
>> Just checking that I understand: Does this mean that we now require an
>> MSVC-version that has stdint.h? If so, I'm not against such a case.
>> IMO, the biggest benefit of using MSVC is not building on legacy
>> systems, but being able to use it's debugger. And for that purpose
>> it's probably OK to increase the required version.
>
> Ouch, that was not intentional. What minimal MSVC version is currently
> supported and who decides if it is OK to increase required one?

I don't know what the oldest one anyone have ever used, but I don't
think that matters. IMO, just noting it in the commit-message is good
enough. Others might feel differently, though.

stdint.h is available in VS10 and onwards.
contrib/buildsystems/Generators/Vcproj.pm generates project files for
VS9.
