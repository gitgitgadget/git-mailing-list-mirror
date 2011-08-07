From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 4/6] git-check-attr: Normalize paths
Date: Sun, 07 Aug 2011 06:32:08 +0200
Message-ID: <4E3E1548.3080502@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu> <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu> <7v4o1zg20r.fsf@alter.siamese.dyndns.org> <4E3A12B9.1010800@alum.mit.edu> <7vliv95cpb.fsf@alter.siamese.dyndns.org> <4E3B8CAA.4030002@alum.mit.edu> <7vaabn52bb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 06:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpvQQ-0003In-Bd
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 06:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829Ab1HGEcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 00:32:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52908 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1HGEcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 00:32:12 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.1.40] (host196-200-static.38-79-b.business.telecomitalia.it [79.38.200.196])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p774W5fN003720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 7 Aug 2011 06:32:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vaabn52bb.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178897>

On 08/05/2011 05:02 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If I understand you correctly, the use of some API routines requires a
>> chdir by the caller (i.e., the surrounding application) *before* calling
>> into the routine.  This is certainly a bit cleaner than the library
>> chdiring itself, but it is still unusable in a multithreaded context.
> 
> Why?
> 
> Presumably you know what your threads are doing, so if you take input from
> the end user after you started the environment, you will be doing the
> prefix discovery and pathspec prefixing on the entry and prefix stripping
> upon output but do not have to (and should not be doing) chdir at all.

I must have misunderstood your earlier message.  Indeed, if none of the
git functions that one would want to libify require that CWD==project
root, then all is OK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
