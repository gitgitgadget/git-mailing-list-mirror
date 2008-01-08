From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [PATCH] Allow git-mergetool to handle paths with a leading
	space
Date: Mon, 7 Jan 2008 20:19:33 -0500
Message-ID: <20080108011933.GE27800@mit.edu>
References: <47809E7E.2090708@dawes.za.net> <7vodbz5ka9.fsf@gitster.siamese.dyndns.org> <4780B2BD.6020109@dawes.za.net> <7v3atb5g5o.fsf@gitster.siamese.dyndns.org> <4781D6C2.9060305@dawes.za.net> <7v8x320zom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rogan Dawes <rogan@dawes.za.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 02:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC38W-0000ES-II
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 02:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758629AbYAHBTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 20:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758626AbYAHBTq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 20:19:46 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37211 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758158AbYAHBTp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2008 20:19:45 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m081JbMk016343;
	Mon, 7 Jan 2008 20:19:37 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m081JXuE007216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Jan 2008 20:19:34 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JC37t-0008VA-5u; Mon, 07 Jan 2008 20:19:33 -0500
Content-Disposition: inline
In-Reply-To: <7v8x320zom.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69832>

On Mon, Jan 07, 2008 at 01:09:45AM -0800, Junio C Hamano wrote:
> Rogan Dawes <rogan@dawes.za.net> writes:
> 
> I did not however apply your patch to my tree tonight, as Ted as
> the original and the primary author of the script may have
> better ideas, and/or future directions for the patch.  He can
> simply just Ack your patch if he chooses to.

Acked-by: "Theodore Ts'o" <tytso@mit.edu>

> In the longer term, I'd probably suggest redoing the entire
> command in a NUL safe scripting language (or even C, especially
> if pressed by mingw or msys folks) to eliminate the issue
> altogether, though.  But that would definitely be a post 1.5.4
> item.

Yeah, we eventually need to redo "git mergetool" in C.  One of the
reasons for that is at the moment it can't take advantage of the
rename detection machinery, so in the case where there is a merge
conflict involving a file that has been renamed in one of the two
branches, "git mergetool" doesn't do the right thing.

Even if it would be possible to expose the rename machinery in a form
that would be convenient for a shell script, it's past time to rewrite
it in C, I think....

						- Ted
