From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Sun, 3 Mar 2013 17:07:56 -0500
Message-ID: <20130303220756.GN22203@biohazard-cafe.mit.edu>
References: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
 <20130303205232.GL22203@biohazard-cafe.mit.edu>
 <7vfw0cb2xi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 23:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCH51-00053t-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 23:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab3CCWIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 17:08:01 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:47693 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753672Ab3CCWIA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 17:08:00 -0500
X-AuditID: 1209190f-b7f586d000000915-16-5133c9bf70e5
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.B2.02325.FB9C3315; Sun,  3 Mar 2013 17:07:59 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r23M7w4H027077;
	Sun, 3 Mar 2013 17:07:59 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r23M7vcU026911;
	Sun, 3 Mar 2013 17:07:57 -0500
Content-Disposition: inline
In-Reply-To: <7vfw0cb2xi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYrdT191/0jjQYNINE4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj2myTgl/iFT17bjE2ME4Q7mLk5JAQMJH4f24r
	I4QtJnHh3no2EFtIYB+jxNX56V2MXED2BkaJHZM+s0E4nxglvs7qYAapYhFQkbhx+xYriM0m
	oCDxY/46sLiIgJrExLZDLCA2s4C4xLq559lBbGEBB4nPGxaB1fAKWEv0vdrADjF0MqPErGWL
	WSASghInZz6BataSuPHvJVMXIweQLS2x/B8HSJhTwEyi5coUsL2iQDdc29/ONoFRcBaS7llI
	umchdC9gZF7FKJuSW6Wbm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokRFLickvw7GL8dVDrE
	KMDBqMTD+2KRUaAQa2JZcWXuIUZJDiYlUV7Jo8aBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	N4QD5XhTEiurUovyYVLSHCxK4rxXU276CwmkJ5akZqemFqQWwWRlODiUJHgfnQBqFCxKTU+t
	SMvMKUFIM3FwggznARp+AaSGt7ggMbc4Mx0if4pRl2PBtUcvGIVY8vLzUqXEec+BFAmAFGWU
	5sHNgSWcV4ziQG8J874DqeIBJiu4Sa+AljABLZmbbgCypCQRISXVwGgTH/Vskv8EdvXun97P
	3fImLDK+96Jg/ewbF9gOidW01SxJqH5zoozPU3ezTrIRr7hVrOmhV0/X7X3Y+Nl14n+7MJWZ
	nlpGUud4Jlez3jFbn/R0GcvNT7xNtRsjD1dsN5orcTFX5pJDY6qe7+6otc3lP1OS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217362>

On Sun, Mar 03, 2013 at 01:15:21PM -0800, Junio C Hamano wrote:
> Greg Price <price@MIT.EDU> writes:
> > It seems to me that "--all" says two things:
> >
> >  (a) allow unannotated (rather than only annotated)
> >
> >  (b) allow refs of any name (rather than only tags)
> >
> > With "--match", particularly because the pattern always refers only to
> > tags, (b) is obliterated, and your proposed semantics are (a) plus a
> > sort of inverse of (b):
> >
> >  (c) allow only refs matching the pattern
> 
> I would think it is more like "only (a), without changing the
> documented semantics of what '--all' and '--match' are by adding (b)
> or (c)".

Perhaps I'm confused somehow?  I believe (a) and (b) together are the
documented semantics of what '--all' is.  And I believe (c), which
contradicts (b) and indeed goes in the opposite direction, is the
documented semantics of what '--match' is.

Certainly we could choose to resolve the conflict by saying that
'--match' overrides '--all', so that '--all' plus '--match' means
(a)+(c).  I believe that's what you suggested.

I think it would be preferable to recognize the conflict and let the
user sort out what they actually mean, because if they (or their
script) gave these options together then I think there's a substantial
likelihood that they are confused or their script is buggy.  If they
mean (a)+(c), they can get it more clearly with '--tag --match'.



> I do not think in the longer term it is wrong per-se to change the
> semantics of "--match" from the documented "Only consider tags
> matching the pattern" to "Only consider refs matching the pattern",
> and such a change can and should be made as a separate patch
> "describe: loosen --match to allow any ref, not just tags" on top of
> the patch I sent which was meant to be bugfix-only.

Yeah, that could be useful.  What form of pattern would you suggest
that the new '--match' accept?  The obvious, and unambiguous, form of
pattern is glob patterns on the full ref name, as with 'for-each-ref'.
Those are a little unwieldy for interactive use, but are perfect for a
script.  And probably 'describe --match' itself already makes the most
sense in a scripted context, as for interactive use one can go into
'gitk' or 'git log --oneline --decorate' or the like and find out the
same information plus more detail.

Particularly when handling both tags and other refs, I can also
imagine wanting to specify a disjunction of several patterns.  So we
might want to accept the option several times cumulatively.

I'd worry about changing the semantics of existing 'describe --match'
invocations in people's scripts, etc.  Perhaps we'd give it a new name
like '--match-ref'.  Or we could say something like, if it starts with
"refs/" it's a pattern on the whole refname, else it's a pattern on
just the tag name, and accept that if someone has a ref called
"refs/tags/refs/foo" and was finding it with 'describe --match' then
that will break until they edit the pattern.

Cheers,
Greg
