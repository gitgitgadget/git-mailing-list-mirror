From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] perf: make the tests work in worktrees
Date: Wed, 11 May 2016 10:08:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605111004020.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <63972edcda32c3c927e956f2e96d5b61843d64f2.1462894344.git.johannes.schindelin@gmx.de> <xmqq7ff1ody6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:09:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PDF-0003oP-6y
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcEKIJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:09:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:50530 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcEKIJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:09:18 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MYwVv-1b4Roy0uhf-00Vi0F; Wed, 11 May 2016 10:09:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7ff1ody6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xvwTPv+HxObWzyrOpnjYB4h3Y9H2ty7s2IpgdGdvU/FBprvORyR
 eufTe8ro7msQ1sVbTOSYDj7RXvP0JIW1bzAMAdqKmCcAExEI42taH1zJxG0GQQFFohwi1aG
 KLAPxFPoZyiWGr7piIxBh3NsPvUTTeK/emqzag+4Zn6GfRzwikXyAjMy0kYZtUdUIwVWhsA
 1aTcvGcMEbBuLmFKL4Q2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gmFkR9xLyd0=:LTfkHPwlEcjuMWzow1kpZw
 8dBQLxpWh4sdLi85qfQRnhGWoMPHDWjzzxPZUgAvSPbVMHOCHiyPn9PAnrH+4+LvGRSx7IBSz
 N8+GC1Zs03dTIR4qj9+wDQ/7faUStYa+a0OgSoLf4XPto9MVMANQLrQjN/xqg7pY3slrAzC/z
 wfVAIXVzbWjOzm9uNDnmceOfi2aAKyef6EVOFXdp7XLDiEAthYMtmaZ6HxQl9gOMNX9KbJc5f
 4YoMXtnGEXpdCg6083xNvytlgAWPJ29YarXkNqYlnVgCpQ1lhv5LpaX6X29WUqX0Z+VNC/7rn
 l3/oNiYRfhy8Pr/0gpXDwOTHqZWksHBE6/o5aXYNZn/rFsLzRtQMsd+HUDD5eyBnAi0r/sf/J
 low3mrNMOZTCsqfI8hpDz+r+eeZxj8bPAJoSO91CxpMKaUH65uxOOCBzgzRLQP2xb/CrKqafy
 7T53Gu2fIqeVwMObkTOkU2kmIm/06sSoTGQTdllpO0ZQN8LaKZx2O2HuGE0ZjiCAMYvCBR4fs
 +PMOznDRJaCvBG7tBo6gQIDWUk9BboeaKHf3QWG8KbL8GhH4VWnSOOAdTJ+YQmKVRrGmI+3ku
 ovnTqU9dIkX8n5RkybdpVvbRvkm30doR3LpQs7GN0Tk8wIbgrft1VAYw1KDW0pKEge4YZY7rT
 l9t4L9a68mnRzaNkWW0O8mnjPK+yGQhUQiCk1apAadjI3V90dkPgNIcImS7KKxNFVP2i+Qy8/
 swwDMiFiQD6x3qMzeAZH6fF1l/TBcX1C14I8uCC1sVFefUhfZyNGsV/lRUAHcfpQxV5Vn3l2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294235>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> > index e9020d0..e5682f7 100644
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -80,22 +80,22 @@ test_perf_create_repo_from () {
> >  	error "bug in the test script: not 2 parameters to test-create-repo"
> >  	repo="$1"
> >  	source="$2"
> > -	source_git=$source/$(cd "$source" && git rev-parse --git-dir)
> > +	source_git="$(cd "$source" && git rev-parse --git-dir)"
> > +	objects_dir="$(git rev-parse --git-path objects)"
> 
> I do not quite understand this change.  Whose object_dir is this
> looking into?  The original wanted to peek into $source/.git/objects/
> which may have been wrong when $source is borrowing from some other
> repository, but the new invocation of rev-parse --git-path objects
> is done inside what repository?  It does not seem to pay any attention
> to $source and the change below just copies from there into $repo.

Bah. This got messed up in one of my interactive rebases. And then I
missed it in my final look-over before sending. Sorry. Fixed in v2.

Ciao,
Dscho
