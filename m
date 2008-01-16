From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 19:38:40 +0100
Message-ID: <20080116183840.GB3181@steel.home>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <7v1w8hslhw.fsf@gitster.siamese.dyndns.org> <a5eb9c330801161010h41e55486y5e8a4335dd939b73@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:39:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDAR-0006wq-0P
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbYAPSiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYAPSiq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:38:46 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:45724 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYAPSip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:38:45 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFj/1U=
Received: from tigra.home (Fad79.f.strato-dslnet.de [195.4.173.121])
	by post.webmailer.de (klopstock mo27) (RZmta 15.4)
	with ESMTP id k05b5ak0GG69px ; Wed, 16 Jan 2008 19:38:43 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 25FD6277AE;
	Wed, 16 Jan 2008 19:38:41 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0747F56D22; Wed, 16 Jan 2008 19:38:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801161010h41e55486y5e8a4335dd939b73@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70717>

Paul Umbers, Wed, Jan 16, 2008 19:10:43 +0100:
> > After seeing the above error, running the test with -i (stop
> > immediately on failure):
> >
> >         $ cd t
> >         $ sh -x ./t0000-basic.sh -i -v
> >
> Tried Junio's latest suggestion. The resulting output and contents of
> the trash are attached as a tar.gz. Thanks for all your help guys, I'm

Well, either it didn't work or you omited something critical (like
stderr):

    * expecting success: tree=$(git write-tree)
    * FAIL 5: writing tree out with git write-tree
	    tree=$(git write-tree)

that is too short. All the traces missing. Could you please retry
with

    sh -x ./t0000-basic.sh -d -v -i &> test_results.txt

? If that is what you actually did, I suspect you have a very broken
shell installed. Could you check if you have bash (bash --version)
and try it instead of "sh"?
