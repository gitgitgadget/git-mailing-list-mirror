From: Roberto Nibali <ratz@drugphish.ch>
Subject: Re: [PATCH] merge-recursive: Improve the error message printed when
 merge(1) isn't found.
Date: Mon, 30 Jan 2006 00:42:13 +0100
Message-ID: <43DD52D5.8080003@drugphish.ch>
References: <43DB4D16.6050807@drugphish.ch> <20060129120344.GB4815@c165.ib.student.liu.se> <20060129121608.GC4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jan 30 00:42:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3MBY-0006ty-Rh
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 00:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWA2XmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 18:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWA2XmS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 18:42:18 -0500
Received: from drugphish.ch ([69.55.226.176]:23196 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S932085AbWA2XmR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 18:42:17 -0500
Received: from [172.23.2.3] (adsl-dyn-83-173-208-107.cybernet.ch [83.173.208.107])
	by www.drugphish.ch (Postfix) with ESMTP id 82736406C005;
	Mon, 30 Jan 2006 00:42:16 +0100 (CET)
User-Agent: Thunderbird 1.5 (X11/20051201)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060129121608.GC4815@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15249>

> -            [out, code] = runProgram(['merge',
> -                                      '-L', branch1Name + '/' + aPath,
> -                                      '-L', 'orig/' + oPath,
> -                                      '-L', branch2Name + '/' + bPath,
> -                                      src1, orig, src2], returnCode=True)
> +            try:
> +                [out, code] = runProgram(['merge',
> +                                          '-L', branch1Name + '/' + aPath,
> +                                          '-L', 'orig/' + oPath,
> +                                          '-L', branch2Name + '/' + bPath,
> +                                          src1, orig, src2], returnCode=True)
> +            except ProgramError, e:
> +                print >>sys.stderr, e
> +                die("Failed to execute 'merge'. merge(1) is used as the "
> +                    "file-level merge tool. Is 'merge' in your path?")

This has my vote as well.

Thanks for your support,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
