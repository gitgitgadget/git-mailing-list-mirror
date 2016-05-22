From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Sun, 22 May 2016 17:03:16 +0900
Message-ID: <20160522080316.GA19790@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 22 10:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4OMH-0000ny-4b
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 10:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbcEVID1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 04:03:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:49776 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbcEVIDX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 04:03:23 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b4OM0-0005AT-9h; Sun, 22 May 2016 17:03:16 +0900
Content-Disposition: inline
In-Reply-To: <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295258>

On Sun, May 22, 2016 at 08:07:05AM +0200, Torsten B=F6gershausen wrote:
> On 22.05.16 01:17, Mike Hommey wrote:
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >  connect.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/connect.c b/connect.c
> > index c53f3f1..caa2a3c 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -742,6 +742,12 @@ struct child_process *git_connect(int fd[2], c=
onst char *url,
> >  			transport_check_allowed("ssh");
> >  			get_host_and_port(&ssh_host, &port);
> > =20
> > +			/* get_host_and_port may not return a port even when
> > +			 * there is one: In the [host:port]:path case,
> > +			 * get_host_and_port is called with "[host:port]" and
> > +			 * returns "host:port" and NULL.
> > +			 * In that specific case, we still need to split the
> > +			 * port. */
> Is it worth to mention that this case is "still supported legacy" ?

If it's worth mentioning anywhere, it seems to me it would start with
urls.txt?

Mike
