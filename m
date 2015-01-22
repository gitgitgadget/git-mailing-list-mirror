From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by
 default
Date: Fri, 23 Jan 2015 07:55:17 +0900
Message-ID: <20150122225517.GB31912@glandium.org>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
 <20150122130036.GC19681@peff.net>
 <CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
 <vpqa91ahg46.fsf@anie.imag.fr>
 <20150122183538.GA20085@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 23:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQfM-0005eb-Qa
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbbAVWzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:55:53 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:44811 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbbAVWzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:55:51 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEQej-0000aa-SB; Fri, 23 Jan 2015 07:55:17 +0900
Content-Disposition: inline
In-Reply-To: <20150122183538.GA20085@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262880>

On Thu, Jan 22, 2015 at 01:35:38PM -0500, Jeff King wrote:
> On Thu, Jan 22, 2015 at 06:36:41PM +0100, Matthieu Moy wrote:
> 
> > > Yes, main point is size of executable.
> > 
> > The Git executable is a few megabytes, i.e. 0.001% the size of a really
> > small hard disk. The benefit seems really negligible to me.
> 
> I don't know the layout of the symbols with respect to the code, or
> whether the stripped version might reduce memory pressure. So in theory
> it could have a performance impact.

It doesn't. Debugging info is in a part of the file that is not mapped
in memory, and in a part that can be removed without affecting the rest
of the file, so it's more or less at the end.

Mike
