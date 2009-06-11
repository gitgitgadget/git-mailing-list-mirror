From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
Date: Thu, 11 Jun 2009 18:42:01 +0200
Message-ID: <BDDDCC14-2EC0-4F34-AACE-0B0A3D8481B8@dbservice.com>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com> <bUVdoksYaP8iWWwjmEaaKuJWLMjhg9vaKu35QNnhoSMM0G7B3XoanQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 11 18:42:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEnMN-0007jq-Sa
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZFKQm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 12:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbZFKQm3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 12:42:29 -0400
Received: from office.neopsis.com ([78.46.209.98]:54384 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbZFKQm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 12:42:28 -0400
Received: from calvin.emmen.dbservice.com ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Thu, 11 Jun 2009 18:42:28 +0200
In-Reply-To: <bUVdoksYaP8iWWwjmEaaKuJWLMjhg9vaKu35QNnhoSMM0G7B3XoanQ@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121347>


On Jun 11, 2009, at 5:50 PM, Brandon Casey wrote:
>
> There are additionally patches on 'next' and more in the pipeline on  
> 'pu'
> which adjust these feature macros when compiling on Solaris.  See the
> bc/solaris series 8fccb00 which was merged to 'pu'.

Alright, just wanted to make sure that issue is known.

> Also, if you happen to be using the Sun Studio suite 12 with c- 
> compiler
> version 5.9, I'd be interested to know whether you can compile diff- 
> delta.c,
> or whether you get an error (see commit 203ee91f).


I happen to have access to some of my university's solaris boxes with  
the following compiler: Sun C 5.9 SunOS_sparc Patch 124867-02  
2007/11/27, I hope that is good enough.

$ gmake CC=/opt/SUNWspro/bin/c99 CFLAGS="" OPENSSLDIR=/usr/sfw V=1  
diff-delta.o
GIT_VERSION = 1.6.3.2.354.g5787c
     * new build flags or prefix
/opt/SUNWspro/bin/c99 -o diff-delta.o -c   -D__EXTENSIONS__ -D__sun__ - 
I/usr/sfw/include -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRCASESTR - 
DNO_MKDTEMP -DNO_MKSTEMPS -DNO_MEMMEM diff-delta.c
$ echo $?
0

(btw, I have to clear CFLAGS when compiling with the sun compiler, as  
it doesn't understand -Wall)

tom
