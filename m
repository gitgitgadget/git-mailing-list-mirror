From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: git format-patch doesn't add Content-type for UTF-8 diffs
Date: Tue, 01 Jul 2014 06:38:24 +0200
Message-ID: <53B23B40.1070209@web.de>
References: <53B127DD.8000807@cs.ucla.edu> <20140630173052.GB16747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Paul Eggert <eggert@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 06:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1pqe-0006SA-Qb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 06:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbaGAEjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 00:39:05 -0400
Received: from mout.web.de ([212.227.17.11]:61016 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbaGAEjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 00:39:04 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M7KR8-1WgZu71jk6-00x2MD; Tue, 01 Jul 2014 06:39:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140630173052.GB16747@sigill.intra.peff.net>
X-Provags-ID: V03:K0:9ETEOc3SKfGnxZhr33mhjojrT0/Ev3S4ZEpG3eGEVWjyAE9eC2X
 c4Q6mlIPXgZXLtbBh+e0L71Q5owBkKyACS7rE2hhSeurFBAbhJ6aDq8FGqh2cv0+c+nqYVM
 LouTuL7OJMBxa1j1la06al2pzrYRHRzR8we/Bog6owVpcMd+oIQouAUjmkwfmghy6wzf4Rb
 9w0/RZD2tC7AAiqWR9WPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252709>


>I wonder if it would be enough to do:

>  1. Always add a content-type header, even if the commit is utf-8 and
>     contains only ascii characters. This _shouldn't_ hurt anything,
>     though I suppose it would if you have latin1 (for example) commit
>     messages and did not correctly set the encoding header in your
>     commits.

Does it make sense to call this function (from utf8.c)

int is_utf8(const char *text)

and either add the content-type header for utf-8 (or not)
