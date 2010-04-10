From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Sat, 10 Apr 2010 17:25:29 +0400
Message-ID: <hppu9a$ugq$1@dough.gmane.org>
References: <loom.20100406T161552-321@post.gmane.org> <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com> <alpine.LFD.2.00.1004070842580.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 15:26:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ahV-0000Yt-Ar
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 15:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab0DJN0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 09:26:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:40761 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab0DJN0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 09:26:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O0ahO-0000WX-0h
	for git@vger.kernel.org; Sat, 10 Apr 2010 15:26:10 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:26:10 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 15:26:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004070842580.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144544>

Hi,

On 04/07/2010 04:55 PM, Nicolas Pitre wrote:
> On Wed, 7 Apr 2010, Vitaly wrote:
>
>
> OK then.  What happens if you do the following on the server machine
> where the repository is stored:
>
> 	git repack -a -f -d
>
> How long does this take?
>
> If the "Resolving deltas" takes more than 10 minutes, could you capture
> a strace dump from that process during a minute or so and post it here?

Nicolas, I took strace and sent it to you personally.

Here is the extract (99% of strace is the same):
--------------
access("/home/vitaly/Projects/test/a1/.git/objects/0f/9a3d28766f8b767fb64166139dd65c079512de", 
F_OK) = -1 ENOENT (No such file or directory)
pread(5, 
"x\234\324\275y\\Ni\374\377\177\256\323]\335Q\271S\332\220\"\n\241\10Q\10!$!d/\262"..., 
214850, 8944159649) = 214850
access("/home/vitaly/Projects/test/a1/.git/objects/a5/5430cbc6674b56d7c2d2d81ef5b7d5c8ebdec8", 
F_OK) = -1 ENOENT (No such file or directory)
pread(5, "x\234\354\275\vT\224U\0270<\347\231\v\363\250\244#\f0 
\"\"\"\312ETD\300af"..., 159502, 8944374506) = 159502
access("/home/vitaly/Projects/test/a1/.git/objects/e5/02b7d050d1b81ebc256234e303eac17116c9fb", 
F_OK) = -1 ENOENT (No such file or directory)
pread(5, 
"x\234\324\274yX\24G\3607>\3353\263,\310\342\"7\2.\202\342\1\10\212\210\212\10\236x\341"..., 
61131, 8944534014) = 61131
access("/home/vitaly/Projects/test/a1/.git/objects/5b/6bdba61771e5ba63ba8b43659db1612345c2eb", 
F_OK) = -1 ENOENT (No such file or directory)
pread(5, 
"x\234\324\275\tX\216Y\3747~\237\323\366DOJiyR\236\210B*$!\311\276\223=[\n"..., 
236685, 8944595152) = 236685
-----------------
As for me, it looks very suspicious.

Vitaly
