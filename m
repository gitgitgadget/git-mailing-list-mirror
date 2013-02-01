From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Fri, 01 Feb 2013 09:39:39 +0100
Message-ID: <510B7F4B.7040902@alum.mit.edu>
References: <20130129190844.GB1342@serenity.lan> <5108F056.9040406@alum.mit.edu> <20130130203158.GN1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:40:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1CAL-0008AC-3L
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 09:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3BAIjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 03:39:45 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:56186 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754598Ab3BAIjn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 03:39:43 -0500
X-AuditID: 12074413-b7f786d0000008bb-e2-510b7f4f0e86
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id FB.9E.02235.F4F7B015; Fri,  1 Feb 2013 03:39:43 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r118deS4027801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 1 Feb 2013 03:39:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130130203158.GN1342@serenity.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqOtfzx1ocGI3u0XXlW4mixvnd7E6
	MHmcffSA2ePzJrkApihum6TEkrLgzPQ8fbsE7ozTMzuZCroEKlbu2cDUwPiIu4uRk0NCwESi
	6/xSFghbTOLCvfVsXYxcHEIClxkl9h88zQ7hHGOSmHD9O3MXIwcHr4C2xOqLoSANLAKqEicm
	zGYEsdkEdCUW9TQzgdiiAmESva/PgcV5BQQlTs58ArZABKh+2qcb7CBjmAXEJfr/gYWFBbwk
	rqycywZiCwmUSqyeOQFsDKeAocTW/RNYQWxmAR2Jd30PmCFseYntb+cwT2AUmIVkwywkZbOQ
	lC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERKmwjsYd52UO8QowMGo
	xMNb9J0rUIg1say4MvcQoyQHk5IoL18td6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV5bkBxv
	SmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYKXuw6oUbAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4Up/HFwEgFSfEA7d0Ntre4IDEXKArReopRl2P77/bnjEIs
	efl5qVLivEIgOwRAijJK8+BWwJLSK0ZxoI+Fef+CjOIBJjS4Sa+AljABLWmrBFtSkoiQkmpg
	FFoRsO9Kd62Hvi7joUV7Xv4W8KoKOX4ox19e5ueWF9eZw9ffStH+lmX44p9L1NTXpxXaeHa+
	2cLzakL25RMnFpmHvp37f7fKkczlXKWXt5Qf2um6k+XDu+ygDbLb7yrO5yg1u3mT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215218>

On 01/30/2013 09:31 PM, John Keeping wrote:
> On Wed, Jan 30, 2013 at 11:05:10AM +0100, Michael Haggerty wrote:
>> [...] maybe we should establish a small Python library of
>> compatibility utilities (like a small "six"). [...]
>> But I haven't had time to think of where to put such a library, how to
>> install it, etc.
> 
> If we want to go that route, I think restructuring the
> "git_remote_helpers" directory and re-using its infrastructure for
> installing the "Git Python modules" would be the way to go.  The
> directory structure would become something like this:
> 
>     git/
>     `-- python/
>         |-- Makefile    # existing file pulled out of git_remote_helpers
>         |-- < some new utility library >
>         |-- git_remote_helpers
>         |   |-- __init__.py
>         |   |-- git
>         |   |   |-- __init__.py
>         |   |   |-- exporter.py
>         |   |   |-- git.py
>         |   |   |-- importer.py
>         |   |   |-- non_local.py
>         |   |   `-- repo.py
>         |   `-- util.py
>         |-- setup.cfg   # existing file pulled out of git_remote_helpers
>         `-- setup.py    # existing file pulled out of git_remote_helpers
> 
> 
> It looks like the GitPython project[1] as already taken the "git" module
> name, so perhaps we should use "git_core" if we do introduce a new
> module.
> 
> [1] http://pypi.python.org/pypi/GitPython

This sounds reasonable.  But not all Python code will go under the
"python" subdirectory, right?  For example, I am working on a Python
script that fits thematically under contrib/hooks.

OTOH (I'm thinking aloud here) it is probably a bad idea for a hook
script to depend on a Python module that is part of git itself.  Doing
so would make the hook script depend on a particular version of git (or
at least a version with a compatible Python module).  But users might be
reluctant to upgrade git just to install a hook script.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
