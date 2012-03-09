From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 7/5] transport: optionally honor DNS SRV records
Date: Fri, 09 Mar 2012 08:07:08 +0100
Message-ID: <4F59AC1C.1000406@viscovery.net>
References: <20120308124857.GA7666@burratino> <20120308132155.GG9426@burratino> <CABPQNSYpRGfu7Ew+KstCFsG4YDSx+i-jzHS1Bw0BA4S2hoz4SA@mail.gmail.com> <20120308213545.GB9497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 08:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5tvA-0006ur-LV
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 08:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab2CIHHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 02:07:18 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:42043 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2CIHHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 02:07:14 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5tuv-00030y-7x; Fri, 09 Mar 2012 08:07:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C6F6C1660F;
	Fri,  9 Mar 2012 08:07:08 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120308213545.GB9497@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192683>

Am 3/8/2012 22:35, schrieb Jonathan Nieder:
> (By the way, what platforms don't support BIND and a random number
> generator?)

MinGW, for example:

D:\Src\mingw-git>cat foo.c && gcc -c foo.c
#include <arpa/nameser.h>
#include <resolv.h>
#include <stdlib.h>

void (*x)(long int) = srand48;
foo.c:1:26: error: arpa/nameser.h: No such file or directory
foo.c:2:20: error: resolv.h: No such file or directory
foo.c:5: error: 'srand48' undeclared here (not in a function)

-- Hannes
