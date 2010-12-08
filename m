From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Status of the svn remote helper project (Dec 2010, #1)
Date: Wed, 08 Dec 2010 19:26:21 +0100
Message-ID: <4CFFCDCD.9060602@dbservice.com>
References: <20101107112129.GA30042@burratino> <20101121063149.GA15449@burratino> <20101205113717.GH4332@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 19:26:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQOiq-00027M-C3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 19:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab0LHS0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 13:26:30 -0500
Received: from office.neopsis.com ([78.46.209.98]:45935 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0LHS03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 13:26:29 -0500
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.222,BAYES_00: -1.665,TOTAL_SCORE: -1.443,autolearn=ham
X-Spam-Level: 
Received: from calvin.local ([193.247.250.53])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Wed, 8 Dec 2010 19:26:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20101205113717.GH4332@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163213>

  On 12/5/10 12:37 PM, Jonathan Nieder wrote:
> --------------------------------------------------
> [Out of tree, stalled]
>
> * tc/remote-helper-usability: $gmane/157860
>   . Register new packs after the remote helper is done fetching
>   . Properly record history of the notes ref
>   . Fix ls-remote output when displaying impure refs
>   . Add git-remote-svn
>   . Introduce the git fast-import-helper
>   . Rename get_mode() to decode_tree_mode() and export it
>   . Allow the transport fetch command to add additional refs
>   . Allow more than one keepfile in the transport
>   . Remote helper: accept ':<value>  <name>' as a response to 'list'
>
> The fourth-from-top seems a bit hard to review.  If it really is
> necessary to introduce a separate program with a separate interface,
> maybe a compile-time flag to choose between them would help?

I simplified the code and the requirements on fast-import are much 
lighter now. All I need is a way to tell fast-import to stop writing 
refs and after each commit write its sha1 to stdout. It's possible to 
modify fast-import.c with a small patch to make it behave like that. 
However, I haven't followed the svn remote helper that much lately so I 
don't know whether one of the other patches already modifies fast-import 
in this way.

 From the beginning my code was meant to be just an example how the 
interaction between git and the svn remote helper could look like. For 
example I save the svn rev <-> sha1 mapping in notes, which is appears 
to work well. I'll take a look if I'll be able to use the svn-fe in my 
script.

tom
