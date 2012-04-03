From: david@lang.hm
Subject: Re: [GSoC] Designing a faster index format
Date: Tue, 3 Apr 2012 13:15:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com> <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com> <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com> <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com>
 <4F7ABA19.7040408@alum.mit.edu> <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Thomas Gummerer <italyhockeyfeed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:16:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFA9S-0008Gv-UN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 22:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2DCUQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 16:16:16 -0400
Received: from mail.lang.hm ([64.81.33.126]:60951 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab2DCUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 16:16:05 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q33KFoqW011795;
	Tue, 3 Apr 2012 13:15:50 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194642>

On Tue, 3 Apr 2012, Thomas Gummerer wrote:

> Lets take another scenario. Someone changes a lot of files and then executes
> some commands which would usually only read the index. In that case either you
> would need the load time (O(n)) plus the time for merging (O(k*log(n)), as
> described above plus the time for writing the index (O(n)) which usually wouldn't
> be necessary.

note that in a large repository you are not that likely to change a very 
large percentage of the files with one update. yes, there are some use 
cases where this happens, but in general, the number of files changed in a 
changeset grows at a much slower rate than the total number of files in a 
repository. As projects get big they tend to get fewer across-the-board 
changes.

David Lang
