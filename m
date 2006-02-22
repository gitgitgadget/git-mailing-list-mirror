From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 19:22:16 -0800
Message-ID: <7vacckt6vr.fsf@assigned-by-dhcp.cox.net>
References: <43FB6C42.5000208@gorzow.mm.pl>
	<BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
	<Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
	<20060222011338.GL5000@delft.aura.cs.cmu.edu>
	<7v3bicupgb.fsf@assigned-by-dhcp.cox.net>
	<20060222031136.GN5000@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 04:22:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBka7-0000Uo-MM
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 04:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWBVDWV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 22:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWBVDWV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 22:22:21 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33185 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751269AbWBVDWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 22:22:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222031845.FZVS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 22:18:45 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20060222031136.GN5000@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Tue, 21 Feb 2006 22:11:36 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16588>

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> Neat, it only fetches tags that refer to things we already have. Hadn't
> checked what the automatic tag fetcher was doing.
>
> So either introduce temporary local refs that can be removed once the
> tags have been fetched,...

I think it is enough just to disable tag following when you are
promiscuously fetching.  That is, do the tag following only if
the main fetch is going to store a ref because it has tracking
branch for the remote side.  Otherwise the remote tags do not
matter and if you really care about them you can ask with --tags.
