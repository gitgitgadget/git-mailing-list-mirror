From: David Lang <david@lang.hm>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sun, 1 Mar 2015 17:09:12 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1503011707040.12474@nftneq.ynat.uz>
References: <1424747562-5446-1-git-send-email-sbeller@google.com> <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com> <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com> <xmqq1tl9gld9.fsf@gitster.dls.corp.google.com>
 <CACsJy8DKbfU7TBHhT5_qpL0QM3zbxkaF+B4x3hQDpomQ_9OSEg@mail.gmail.com> <xmqqwq30fhbg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 02:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSErJ-0008TW-5p
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 02:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbbCBBJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 20:09:17 -0500
Received: from mail.lang.hm ([64.81.33.126]:46578 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbbCBBJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 20:09:17 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t2219Ctp021863;
	Sun, 1 Mar 2015 17:09:12 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <xmqqwq30fhbg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264573>

On Sun, 1 Mar 2015, Junio C Hamano wrote:

> and if the only time your refs/remotes/origin/* hierarchy changes is
> when you fetch from there (which should be the norm), you can look
> into remote.origin.fetch refspec (to learn that "refs/heads*" is
> what you are asking) and your refs/remotes/origin/* refs (and
> reverse the mapping you make when you fetch to make them talk about
> refs/heads/* hierarchy on the server side), you can compute it
> locally.
>
> The latter will have one benefit over "opaque thing the client does
> not know how to compute".  Because I want us avoid sending unchanged
> refs over connection, but I do want to see the protocol has some
> validation mechanism built in, even if we go the latter "client can
> compute what the state name ought to be" route, I want the servrer
> to tell the client what to call that state.  That way, the client
> side can tell when it goes out of sync for any reason and attempt to
> recover.

how would these approaches be affected by a client that is pulling from 
different remotes into one local repository? For example, pulling from the main 
kernel repo and from the -stable repo.

David Lang
