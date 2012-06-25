From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Add C_LOCALE_OUTPUT prereq to test cases that
 require English text matching
Date: Mon, 25 Jun 2012 06:53:17 -0500
Message-ID: <20120625115317.GC9270@burratino>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <1340541692-10834-2-git-send-email-pclouds@gmail.com>
 <20120624162807.GB18791@burratino>
 <CACsJy8DpOL+V=sVZt3B-7OQ=POHtu1bovFB-sQ9HwPpmdKmN-A@mail.gmail.com>
 <CACsJy8BMizkU+P6VPhkbY_q2tYY5=aY-GNHeDjBYN9-zg2nENQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 13:53:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7rD-0006Cl-Qo
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab2FYLxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 07:53:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41860 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2FYLxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 07:53:22 -0400
Received: by yenl2 with SMTP id l2so2680012yen.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SS3xuI10i87NXmAn/KFYeXPBKmj2fIC9Yj0a1qPQT2w=;
        b=MwxYl4nbjIBgKQE7SiLsoVjO3Cntz+z+eEEGEWbFVXJxzkBQ2m2CEJwDhsH5ZhR8tG
         eNf0vkytNBxa7+SREA5uFZj0FX8KnAFyoukTbZHSNuHcuv/eRt7g4kmj1toDSWbQHnRv
         7pO0CyMpk8sI2jAYJzQjUG7e0n8HgmpIuP8iUGUhyk5zXsxP4FHtO+CtKsNWveLNo45R
         g1bN3YeHoGWqDh1PwZtpR7pRA9wn3PIryEOZqQ3b2sqruWQYLVDifb2ZnZytNVYa4pSK
         UeTm/Ds+H3eav/id5ahQg6VM7qa+08QwR3l2c0IsUaags02zKNfy3BzvdWy45UQ6Eg5Y
         CFZg==
Received: by 10.50.94.169 with SMTP id dd9mr7676432igb.7.1340625202020;
        Mon, 25 Jun 2012 04:53:22 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ud8sm16097400igb.4.2012.06.25.04.53.21
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 04:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BMizkU+P6VPhkbY_q2tYY5=aY-GNHeDjBYN9-zg2nENQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200573>

Nguyen Thai Ngoc Duy wrote:

> What if we allow to run the test suite in non-C locales and skip the
> tests that require C_LOCALE_OUTPUT? In non-C locales, we won't set
> C_LOCALE_OUTPUT prerequisite. This allows to test a localized git with
> ~90% of the test suite. Would it work?

Yes, of course, modulo bugs. :)  I guess one thing to watch out for
would be assumptions about non-git utilities in the test suite --- for
example, some commands such as "sed" have a different idea of what a
character is in other locales.  But the main ingredient needed is just
UI (a test option or envvar).
