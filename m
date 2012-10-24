From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 11:08:08 -0700
Message-ID: <20121024180807.GA3338@elie.Belkin>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 20:08:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR5NU-0001DV-NH
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 20:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935419Ab2JXSIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 14:08:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51249 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935409Ab2JXSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 14:08:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so535460pad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IyPX3wDjx1aEti9hBGi4XKsdxb7E4DDuQJ1fr2rYQUU=;
        b=F00e9OkKvpcry+iv5JwqX+GU6v8QuZX1Sp2VwWvXunC5D0cYBsVqcDkrZcjX0cj1ML
         drJQ72zUQRipw9iqh41wu1ttStCDiWzQ0ibz5uct+KcmF9sspmTtiD8l3oF269Hctbca
         3NDUOOBu7dX5moEx6xy99RksQOxi94/A8HIvdEDvKzNghQ3xck+k74SOLBK2NokG9Z/P
         imIrM32HmAX2qcPSP2uG5eWxwZ3cITOkD+JC2Mph+E8Stv2OgwAQjQY5jBED7I1hxNbE
         i5nMottl3rvPri6L4aiJfuN0LWpVLMj3+pltX9NoKdzBMK3whEPoEatgBWHmwNpqy24h
         BxNA==
Received: by 10.66.87.132 with SMTP id ay4mr16202935pab.67.1351102095630;
        Wed, 24 Oct 2012 11:08:15 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id k6sm6002476paz.8.2012.10.24.11.08.13
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 11:08:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208314>

Hi Felipe,

Felipe Contreras wrote:

> This test is completely wrong.
>
> 1) Where are the marks file?
> 2) master..master shouldn't export anything

Why shouldn't master..master export anything?  It means "update the
master ref; we already have all commits up to and including master^0".

The underlying problem is that fast-export takes rev-list arguments as
parameters, which is unfortunately only an approximation to what is
really intended.  Ideally it would separately take a list of refs to
import and rev-list arguments representing the commits we already
have.

Hoping that clarifies,
Jonathan
