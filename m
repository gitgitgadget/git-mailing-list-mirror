X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 01:35:11 +0100
Message-ID: <20061117003510.GB7201@pasky.or.cz>
References: <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org> <455CFCBD.8040901@xs4all.nl> <7vmz6r2amf.fsf@assigned-by-dhcp.cox.net> <455D0209.7070608@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 00:35:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <455D0209.7070608@xs4all.nl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31645>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrhO-000170-UZ for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424816AbWKQAfO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424815AbWKQAfO
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:35:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58325 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424818AbWKQAfM (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:35:12 -0500
Received: (qmail 8374 invoked by uid 2001); 17 Nov 2006 01:35:11 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 01:27:53AM CET, Han-Wen Nienhuys wrote:
> put clone would be the putative inverse of clone, ie. make a clone of
> a local repository on a remote server.

So effectively to tell git push not to unpack on the remote side, and to
push all branches and relevant tags.

..snip..
> It's more logical for clone to either
> 
>  * leave all names unchanged
> 
>  * put all remote branches into a subdirectory.  This would also make
>    it easier to track branches from multiple servers.
> 
>    At present,  I have in my build-daemon the following branches,
> 
> 	cvs-head-repo.or.cz-lilypond.git
> 	hanwen-repo.or.cz-lilypond.git
> 	hwn-jcn-repo.or.cz-lilypond.git
> 	lilypond_1_0-repo.or.cz-lilypond.git
> 	lilypond_1_2-repo.or.cz-lilypond.git
> 	lilypond_1_4-repo.or.cz-lilypond.git
> 	lilypond_1_6-repo.or.cz-lilypond.git
> 	lilypond_1_8-repo.or.cz-lilypond.git
> 	lilypond_2_0-repo.or.cz-lilypond.git
> 	lilypond_2_2-repo.or.cz-lilypond.git
> 	lilypond_2_3_2b-repo.or.cz-lilypond.git
> 	lilypond_2_3_5b-repo.or.cz-lilypond.git
> 	lilypond_2_4-repo.or.cz-lilypond.git
> 	lilypond_2_6-repo.or.cz-lilypond.git
> 	lilypond_2_8-repo.or.cz-lilypond.git
> 	master-git.sv.gnu.org-lilypond.git
> 	master-hanwen
> 	master-repo.or.cz-lilypond.git
> 	origin-repo.or.cz-lilypond.git
> 	stable
> 	stable-2.10
> 	stable--2.10-git.sv.gnu.org-lilypond.git
> 
>   It would solve lots of problems for me if cloning and fetching would
>   put branches into a subdirectory, ie.
> 
>     git clone git://repo.or.cz/lilypond.git
> 
>   leads to branches
> 
>     repo.or.cz/lilypond_2_8
>     repo.or.cz/lilypond_2_6
>     repo.or.cz/lilypond_2_4
>     repo.or.cz/master
>      (etc..)

That's basically exactly what git clone --use-separate-remote should do.
Now only if it would become the default... :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
