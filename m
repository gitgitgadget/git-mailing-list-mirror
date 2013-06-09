From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun, 9 Jun 2013 14:16:29 -0500
Message-ID: <CAMP44s0dNM2L7u=XPP82DnKFXmgC-kC6yeJYAgCPLeMEgJaH3A@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
	<20130609181724.GA11516@paksenarrion.iveqy.com>
	<CAMP44s3VL-uDPcsUyaYX3ESFbdj7h0XGuVZD+y8J_KewHcPC5g@mail.gmail.com>
	<20130609190814.GA12122@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ull6R-0006OE-Fg
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab3FITQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:16:31 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:56548 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab3FITQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:16:30 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so3573413lab.26
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wryly0bxRH+Hv2Dgya8auY5CAQp3e+uayIPh7mGFIoI=;
        b=tX1oy2UFvzBzxQ07lgeEF6bu6iH9Tl92i/Pg7eADCOOoQpQsxPsTVEzYZGL7O5z9nd
         eLHpiGKE2I2iWfbr0oBvntUvU0KxGV5etus+clyYbC87M6NGzYVSLZrbG5dtiIotfKD/
         FwrKcWjJTnThKG+2HJgWZO7zUkAeXjR2clWXB48JtuY2njKQ00/++NQa5tzv2VA3dUzv
         6ACAoGB6IxOy329CWc69OhwhZxNngn1v9GQoShotARdLV4S8jUeMqToQ0U1KaW8rFmDA
         3wXOs4HxzlS5fkNljzF3hhC1klRCtXwGaQFgHEepvLQwtMmj/MUynahuUX4plVWwAbK+
         of/w==
X-Received: by 10.152.22.73 with SMTP id b9mr3478345laf.36.1370805389282; Sun,
 09 Jun 2013 12:16:29 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:16:29 -0700 (PDT)
In-Reply-To: <20130609190814.GA12122@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227104>

On Sun, Jun 9, 2013 at 2:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jun 09, 2013 at 01:19:03PM -0500, Felipe Contreras wrote:
>> The explains what the patch is doing, but not why. Why is more important.
>
> You're right. Why are the indentation useless? It doesn't seem to be
> useless until you added goto. So why is your goto solution better than
> the previous existing solution?

Because it removes useless indentation :)

This is what they do in the Linux kernel, you tell me which looks better:

a)

	if (function1())
		goto leave;
	if (function2())
		goto leave;
	if (function3())
		goto leave;
	if (function4())
		goto leave;
	good_stuff();
leave:
	final_stuff();

or b)

	if (!function1()) {
		if (!function2()) {
			if (!function3()) {
				if (!function4()) {
					good_stuff();
				}
			}
		}
	}
	final_stuff();

-- 
Felipe Contreras
