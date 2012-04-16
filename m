From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 11:07:29 -0500
Message-ID: <20120416160729.GM5813@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoSs-0001Z0-MC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab2DPQHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:07:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37460 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2DPQHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:07:37 -0400
Received: by obbta14 with SMTP id ta14so3800442obb.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dm/0WjevWmUxrTI40ZbkzWb40w9YbH+1DtOuX7AKWq4=;
        b=xbidUoMAwHjyldh77VX2evcmXqv8mpGgGmiMMlLR1XR5z6+WDSRdvEYTqz6y4cgC3T
         axfdsf/WbwbsLjMSwzhmxZcn8OJPooWBDxcIadbNqbNjuwkxpcIobNhio8xIS2GVheYm
         furRsX2v/Y8jSN+QBJxgRoujJurxdJabtPrNswaDHiIKUdyCImJTf8pWUavITFlJJuLA
         2q7hV4H6+XEAhPzaSRxX6AOKP+TgNM15N5tgXMouclOIiklYSlz56CSO02EmBWVN4CrA
         sBjJ6MHHtLNPqncGCeBZPp3uaz/EmDytNAs9NEc/7/idte3iN1u0ENgFmTj5R4ERjvRI
         YHYQ==
Received: by 10.182.26.15 with SMTP id h15mr17006891obg.27.1334592456901;
        Mon, 16 Apr 2012 09:07:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n9sm15830205oen.2.2012.04.16.09.07.35
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:07:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195657>

Junio C Hamano wrote:

> I am OK with introducing git_ps1 while keeping __git_ps1 as an equivalent
> and declare that git_$anything will be the surface interface for end users
> to *use* the machinery we provide, though.

The problem is that completion scripts are often included implicitly
in .profile through the bash completion machinery.  Users do not have
to explicitly ask for them, so there is no reason for users to expect
that the function name "more_cowbell" is dangerous to use in .profile
because some day the completion script for the "more" command will
start using it.

Because of these considerations, the convention is that every
identifier provided by a completion script, including public ones,
starts with an underscore.
