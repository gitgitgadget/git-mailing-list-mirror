From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 23 Aug 2013 20:56:14 -0400
Message-ID: <20130824005614.GC8182@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130823115920.GB8182@jerec>
 <5217BB34.9080502@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD29P-0006Fd-9M
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab3HXA4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:56:19 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:43587 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab3HXA4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:56:18 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so345277ghb.11
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 17:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wSV+3QDPbE3q5N+jkwxZroeRd/TxEQkE8f0rLTLjK1g=;
        b=mtU7/iURL1m5RzH2I5DigjrSYhRVKcOfvqC7JmAsu3ANHj00nqt3wXr7NTRSxmOpSK
         yG2Es6n+noN7Zd2dG/J45id6DNT4jMPzXUY0+svt7OFTJeSWkTy8ojPV3Ppa2UuP3gz9
         jidJGWOkwC0oFUDVezI3KsuSwkFkXI/I7EXdVPUxV3xRLyILMXEaZn1zD28gOAWVt15u
         2SfymFgaKqZdbL6xzvEM4xoxH6TueBrAEtmdyk1y83a92KrpR7jrJi0x+EkbBcPlwTY9
         eDiDqYofzpiMuIEjfVnK1hpb+snrDYH93/yY4AqAdp0VDoq0P7ilcAVLGsJDE2a7SJY0
         D19w==
X-Received: by 10.236.121.40 with SMTP id q28mr1927330yhh.40.1377305777983;
        Fri, 23 Aug 2013 17:56:17 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id e42sm3379595yhe.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 17:56:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5217BB34.9080502@diamand.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232855>

On Fri, Aug 23, 2013 at 08:42:44PM +0100, Luke Diamand wrote:
> 
> I think I've cloned files as large as that or larger. If you just want to
> clone this and move on, perhaps you just need a bit more memory? What's the
> size of your physical memory and swap partition? Per process memory limit?
> 

The machine has 32GB of memory, so I hope that should be more than
sufficient!

$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 268288
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 10240
cpu time               (seconds, -t) unlimited
max user processes              (-u) 1024
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

Admittedly I don't typically look at ulimit, so please excuse me if I
interpret this wrong, but I feel like this is indicating that the only
artificial limit in place is a maximum of 64kB mlock()'d memory.

Thanks,
Corey
