From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 5/6] format-patch: add format.cover-letter
 configuration
Date: Sun, 7 Apr 2013 15:32:00 -0700
Message-ID: <20130407223200.GF19857@elie.Belkin>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
 <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
 <20130407193415.GB13708@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5q4-0000sy-EM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934444Ab3DGWcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 18:32:09 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45758 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934437Ab3DGWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 18:32:08 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so2909791pdi.36
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4cQOS/ah0YUchYJ+l4p7q3kWmDTen0PiVTBKX//74gs=;
        b=XMbdBGtSE8LZVCc8ifPZbiDmfV86iq3XdSJpqyuOhl2mvAigEfFP6qSYGVJ4TChX6u
         1WGm4SGw/XTIlZ01bgXCCF5ocX/jf3rZygxtxfMY1zIotfYxFOLyFfJyNH95qNy/uEuF
         uf/gqKo72CyjwyWATJLyW8u5/Qq4JuRYNmpKenmlgMbGh0rd/wTs5oVJrX2Y1OOOM7AB
         Ay9GfHDNYUeCUmZccF8CJBS7QZWZJ1Hqe+UZc4K6eYMaS4ja9YEe+5lzBWNLLJSnJiiW
         fZryFgUivNDoxzvBUUSyWlTd735pgfa/FtOjOgk/haEAiS5SYa8V30++6IDaJXWWbY2A
         dWuA==
X-Received: by 10.66.240.2 with SMTP id vw2mr31059318pac.157.1365373927456;
        Sun, 07 Apr 2013 15:32:07 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hp1sm33605494pac.3.2013.04.07.15.32.04
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 15:32:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130407193415.GB13708@ruderich.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220385>

Hi,

Simon Ruderich wrote:
> On Sun, Apr 07, 2013 at 12:46:23PM -0500, Felipe Contreras wrote:

>> +test_expect_success 'cover letter auto' '
>> +	mkdir -p tmp &&
>> +	test_when_finished "rm -rf tmp;
[...]
> I'm not sure if it's better to use test_when_finished with rm or
> just && rm -rf tmp at the end of the test in case someone wants
> to look at the output.

test_when_finished is better here, since it means later tests can
run and provide useful information about how bad a regression is.
Cleanup commands requested using test_when_finished are not run when a
test being run with --immediate fails, so you can still inspect output
after a failed test.

Thanks and hope that helps,
Jonathan
