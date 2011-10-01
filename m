From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git, Mac OS X and German special characters
Date: Sat, 01 Oct 2011 08:39:56 -0500
Message-ID: <4E87182C.8050201@op5.se>
References: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Albert Zeyer <albzey@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 15:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9znX-00007u-Lb
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 15:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1JANkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 09:40:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35870 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab1JANkC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 09:40:02 -0400
Received: by yxl31 with SMTP id 31so2325776yxl.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 06:40:01 -0700 (PDT)
Received: by 10.236.178.41 with SMTP id e29mr4296443yhm.117.1317476400962;
        Sat, 01 Oct 2011 06:40:00 -0700 (PDT)
Received: from vix.int.op5.se ([12.50.161.201])
        by mx.google.com with ESMTPS id u45sm9866628yhh.8.2011.10.01.06.39.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Oct 2011 06:39:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Thunderbird/3.1.14 ThunderGit/0.1a
In-Reply-To: <CAO1Q+jf=RO=sE90-mQdi+=fUWH1RLM+JTubSgSVGC5uDyhU+2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182550>

On 10/01/2011 07:44 AM, Albert Zeyer wrote:
> Hi,
> 
> There are problems on MacOSX with different UTF8 encodings of
> filenames. A unicode string has multiple ways to be represented as
> UTF8 and Git treats them as different filenames. This is the actual
> bug. It should treat them all as the same filename. In some cases (as
> on MacOSX), the underlying operating system may use a normalized UTF8
> representation in some sort, i.e. change the actual UTF8 filename
> representation.
> 
> Similar problems also exists in SVN, for example. This was reported
> [here](http://subversion.tigris.org/issues/show_bug.cgi?id=2464).
> There you can find also lengthy discussions about the topic. And also
> [here](http://svn.apache.org/repos/asf/subversion/trunk/notes/unicode-composition-for-filenames).
> 
> This was already reported for Git earlier and there is also a patch
> for Git [here](http://lists-archives.org/git/719832-git-mac-os-x-and-german-special-characters.html).
> 
> I wonder about the state of this. This hasn't been applied yet. Why?
> 

Because the patch didn't address repositories carrying files with
more than one possible representation of the filename and that
could have lead to silent loss of data for unsuspecting users.

The real solution to your problem is, unfortunately, to either use
a different and more competent filesystem, or to avoid triggering
the bugs in the one you're currently using.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
