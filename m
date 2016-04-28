From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 14:19:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604281405540.2896@virtualbox>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de> <cover.1461837783.git.johannes.schindelin@gmx.de> <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:21:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkwP-0001ej-1y
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 14:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbcD1MVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 08:21:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:54403 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbcD1MVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 08:21:04 -0400
Received: from virtualbox ([89.204.153.107]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LZmd6-1bPGid1MxI-00lTJp; Thu, 28 Apr 2016 14:19:39
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160428112912.GB11522@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qBEN6lXoXltvyn0eIK07oPqe5Cd3aRmZrL3byMvv3S+UOeJNa2l
 I+YMBXkW2+1risAagU1KJ8dg7Zuw4IdTv8M15ksTLpJ35FJD+ccNlmC03BYOxppQCAm/iKv
 b6hlW/pKfdMXajUmd3XFDLPjC2pPnqrDHOLcIXLh4Uhpqtlhlm+Y6kCLUYQOEsWFo3Hv1RK
 jxl+c/GaLjhDcwpkphyvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGHxmMkYZNM=:y8ANmnCikAXaHP3qKQjQCe
 Dwd5Ju3E5Jd6uhwf32OjsxXAQM3NNC2ZpX0Bx5Ec2kZU0VmOPq/HIJVMTn4f3OUSKc9bKaMPP
 bNqYNLKJHRc1KstfL9neTtCGPHroVAuB6m8551vsTffxOIRzB52e/kbT0Kgul7VykhKJKYFqy
 nPhh1wHjBky2wGeFYgdnL4ZddgmdLbGkNgtYxI1awft1rHFfOwQ/ZuC5o1lfltazVEAs/PjPU
 iLsKoGyO8b8ZcHrsmgD35ei8oPl+vKkIk9e99/2zi92FcqC5Yw8ZjHNZPSa+wR8dqH7xeIeRi
 KaMJM9DAdrYO1I7yRffgh7zHJcTGY3xHQrjjZv+FJadwFqA4lgmrSr5WF/czbPs0iy6XZ42T3
 A6z3keo+pW673CfuMPAQuNC4LWA83r2y767HY0Sm8YHc/iIJrk20z5ycYHqMwMtK71Cv9qAOv
 eesDzCEYMzu/y2AavvW+9/8CFQyrufmDJIXrU+KVFsawwNJ/b2JLKs5vcNmRQwa7/zbXGwcpu
 4eyOIQo7+olexE+o+RWkI959lp1s7mZXmbDV4x9jVz9zjY65XypRBaDHD4S3O10dSdThsPCyW
 5JqxQNlyimQvdBIaFDgzjpoY7W4o1o8JgLOKztrdd7hC7UYss2TqVpSITM1X7ZAEEjpzvdTVM
 NZW093EpBilM3KbX+Y9eNpPCf4B7uarhQPVVo0o0DiqgIZborvwfW6pqvpytdyqmknhq84Z82
 tkdnu7oWfsFE3oymnPPkF0kz19PKf3/sBfq0GM1kapbil/FyItOQrRSsfNkMubKGkDHxX7h6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292872>

Hi Peff,

Cc:ing Jacob, the author of the CONFIG_DATA_ENVIRONMENT sanitizing code.

On Thu, 28 Apr 2016, Jeff King wrote:

> On Thu, Apr 28, 2016 at 12:03:47PM +0200, Johannes Schindelin wrote:
> 
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 3bd6883..b338f93 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -127,7 +127,9 @@ static int module_name(int argc, const char **argv, const char *prefix)
> >   */
> >  static int submodule_config_ok(const char *var)
> >  {
> > -	if (starts_with(var, "credential."))
> > +	if (starts_with(var, "credential.") ||
> > +			(starts_with(var, "http.") &&
> > +			 ends_with(var, ".extraheader")))
> >  		return 1;
> >  	return 0;
> >  }
> 
> Should we consider just white-listing all of "http.*"?
> 
> That would help other cases which have come up, like:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/264840
> 
> which wants to turn off http.sslverify. That would mean it turns off for
> every submodule, too, but if you want to be choosy about your http
> variables, you should be using the "http.$URL.sslverify" form, to only
> affect specific servers (whether they are in submodules or not).

I considered that, and thought that it might be dangerous, what with me
not vetting carefully which http.* variables are safe to pass on to the
submodules' update and which are not.

So I had a look now, and the most prominent potential problem is the
http.cookieFile setting, which could be reused all of a sudden if we
made my patch more general.

But then, we are talking about the code that filters what gets passed via
the *command-line*. And to be quite honest, I am not sure that we should
actually filter out *any* of these settings.

The commit message that introduced this particular filtering has this
rationale to let only credential.* through:

    GIT_CONFIG_PARAMETERS is special, and we actually do want to
    preserve these settings. However, we do not want to preserve all
    configuration as many things should be left specific to the parent
    project.

    Add a git submodule--helper function, sanitize-config, which shall be
    used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
    except a small subset that are known to be safe and necessary.

Dunno. I tried to err on the side of caution... But this sounds maybe a
bit *too* cautious?

Jacob, Junio?

Ciao,
Dscho
