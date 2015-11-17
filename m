From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [git-for-windows] Git a single file from remote
Date: Tue, 17 Nov 2015 14:47:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511171441350.1686@s15462909.onlinehome-server.info>
References: <f41ee51a-aee4-41d5-b50d-e47ea3cab611@googlegroups.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	git-for-windows <git-for-windows@googlegroups.com>
To: Chaz <kevinwolf7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 14:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZygbU-0008SJ-11
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 14:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbKQNrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 08:47:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:54970 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbbKQNrT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 08:47:19 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MDhny-1aACeg0nhG-00H4kq;
 Tue, 17 Nov 2015 14:47:16 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <f41ee51a-aee4-41d5-b50d-e47ea3cab611@googlegroups.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:3p6WgT3epyEXRNdu7StIKkuiqPRjUMMhrsD721d9JCY5KB6R7vn
 K35S4EzUtQAnyp6QWGuJSi3GJ2s5iaRRXDYq9EVxhP8dTcqDb1v58hUxwVNFrDEcYAd3mUn
 slK/KSr3LtMEEMAtp5vRqHeZ+ZuhC6el5QWttoBQV+L0F7Q5fPYeIAOyyMGAO6wslEjACfz
 bdG0THNKxzeQjwsMeBNqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UeBikmsXUW4=:Ic0SsYiQ6Fjvecpz3pDjXI
 tOopYU9VOTzf+3RoLzdINtWnHHAI4lCChE/KUh2LSQMAYBuVQ57nUnIdJs2TduAW7YNbWuak/
 rnpU1dEjeyTVd506U87M1kIelW2DYScxTI6qxFTP2poZgCsFAD6gY8+QMI2tOJjL2V4Wvvx/t
 YBpARJVnaWwPWqaVMyYA1k3RPDsZfFgEOhis1Y4tTbL4yEJ47Zpq08gMAAZ5wEIBLc6s8DI5L
 Sln9o+/QDBQ040ZJOKSBJP4H9EtnwDpkqqjpFVg2uh/Zr1k2sQmhCrfycrbs2poFibPFC7kE/
 3Bv0vOEMS8OQV78di97bbBo9XQjo8iy475epKBVBBFg1xA/Q/2Li0fjl9baia+n54i05YQF9F
 6aqIhAPJkOSnEdwo/SpdtmXzTvoAMBHn9t3UdkNS8QJoCmiCmMctFdC4t9HfMqaZyD0CMjtX/
 I9+1cYO1oPlg/7VGOPYQHv1uD0b4BG/boFvAbO8iVxBIG07dfY+/t3KZp+h00ckFzT9XyovjA
 cuYfPUnma5dKwuf9OV36oka6qpMPa+D2phQQHO+QePI7CrlxV2OqZEKBphQ11drgyeV56FsmW
 mWR3HUCFAfCckK8QpXxVgwivxRXVY9QlhHcqoFFT5s3TuKMh9yvpOFmEOFbHyu8sYFazfRJdI
 kmIA7K9g7SgtyElz4eGN750d8hYkGcsvtxVg3y1PiJMSxGVjHY4v4XIV7IKWs28xNYfrK2fLc
 PfGbUR/6cAGeASb9FHfBk022llaJxyMNV30OjGMiyJW4bic9siv4AeXoev+cVsX6DaWwslh/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281408>

Hi Chaz,

On Mon, 16 Nov 2015, Chaz wrote:

> An origin git repository has been setup.  Added a remote repository 
> (remotegit).
> 
> "git remote -v show" displays both origin and remote links.
> 
> What is the best way to copy a single file from the remote repo to the 
> origin repo?

This is not specific to Windows, so it would be more appropriate to send
this question to the Git mailing list (Cc:ed).

Git is not designed to download specific files, at least not by default.

Having said that, some remotes are configured to allow downloading
archives and in such a case you might be able to specify something like
`git archive --remote=<remote> HEAD:README`, but I am personally unaware
of any remote that supports this.

Your best bet may be to fetch an individual ref with the `--shallow`
option.

Ciao,
Johannes
