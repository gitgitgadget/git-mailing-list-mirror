From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug: segfault during git-prune
Date: Mon, 2 Jul 2007 14:25:37 +0100
Message-ID: <200707021425.38367.andyparkins@gmail.com>
References: <200706281134.58453.andyparkins@gmail.com> <200707021100.16610.andyparkins@gmail.com> <alpine.LFD.0.98.0707020441460.3323@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 15:25:52 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5LuU-0001m6-MG
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 15:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbXGBNZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbXGBNZo
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 09:25:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:51907 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbXGBNZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 09:25:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1254683ugf
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 06:25:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=thy+tkIU6L+kSpZ8hyTyz8fWdF0riSNm2XevpAOdJFpp7Eue/wW15EN7PKJyY9lt/A9Dt6H00CH4F0vhhjX/WEsU6H8EKzIFMcw7Q0rYtREV+tr0NO4De7FIUlak5QrBqZrkrYRKHif+dSLEcolFxDeocMPf+n3284EWArg9bsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ic877QcgRsAgYzloPdXvz/JY4Msf9IH7l8grxMZ7VobxzgQUOjvOl+SbsQa9EFW6//Y7yd9Um/JGNQWs/RlHdLLYNlJOxpD7938g9xoaJIZgzz+4sh/GMDuLdn572E+mhDGKAoTC3YEHAPg5wKzx31vlqpQ+ZUNBB+kxCFLNWFs=
Received: by 10.82.186.5 with SMTP id j5mr12900068buf.1183382741894;
        Mon, 02 Jul 2007 06:25:41 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm30000112iky.2007.07.02.06.25.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Jul 2007 06:25:41 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0707020441460.3323@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51362>

On Monday 2007 July 02, Linus Torvalds wrote:

> Just for clarity, I'd use "process_gitlink()" here (and it would probably
> be a good idea to use process_blob() on the blob we look up too), and the
> proper tab indentation, but yes, I think you're otherwise exactly right.

I've pushed it out as-is as a bug fix patch now; and will happilly make the 
above change on top.  However, I've not understood what all the parameters 
are for in the process_XXXX() functions:

static void process_gitlink(const unsigned char *sha1,
			    struct object_array *p,
			    struct name_path *path,
			    const char *name)

the sha1 and name I can read out of the cache_entry structure, but I'm not 
sure about the object_array and name_path structures in the context of 
add_cache_refs().



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
