From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in
 alternate or kept packs
Date: Sun, 22 Mar 2009 13:40:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903221325380.30483@xanadu.home>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
 <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
 <ee63ef30903220748q4e78e626t2ea3930809a670d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_49dSX9w/kLP6zbxnuwznsQ)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 18:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlRga-0001Qs-OT
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 18:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbZCVRkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 13:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbZCVRkf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 13:40:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29176 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017AbZCVRke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 13:40:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGX00FXF53F9HF0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Mar 2009 13:40:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <ee63ef30903220748q4e78e626t2ea3930809a670d6@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114155>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_49dSX9w/kLP6zbxnuwznsQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 22 Mar 2009, Brandon Casey wrote:

> >> +static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
> >> +{
> >> +     static struct packed_git *last_found = (void *)1;
> >> +     struct packed_git *p;
> >> +
> >> +     p = (last_found == (void *)1) ? packed_git : last_found;
> >
> > Why (void *)1, not like:
> >
> >        static struct packed_git *last_found;
> >        struct packed_git *p = last_found ? last_found : packed_git;
> >
> > Am I missing something?
> 
> Heh, I am missing something too.  Maybe I should have _thought_ more
> about this code that I copied from sha1_file.c: find_pack_entry() and
> I would have asked the same question about _that_ code.
> 
> Maybe Nico has some idea?

Well...  I know this is my code, and I must have had a reason to keep 
the NULL pointer distinct from the initial value.  But at the moment I 
just can't remember about it, and the code doesn't show a need for it 
either.


Nicolas

--Boundary_(ID_49dSX9w/kLP6zbxnuwznsQ)--
