From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH v2 2/3] builtin-status: submodule summary support
Date: Sat, 12 Apr 2008 18:13:19 +0200
Message-ID: <200804121813.20050.johannes.sixt@telecom.at>
References: <1207841727-7840-1-git-send-email-pkufranky@gmail.com> <1207841727-7840-3-git-send-email-pkufranky@gmail.com> <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 18:14:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkiN5-0007qz-GN
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 18:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYDLQNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 12:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYDLQNo
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 12:13:44 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:44775 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYDLQNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 12:13:22 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 7FCBD13A33D;
	Sat, 12 Apr 2008 18:13:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4A79362455;
	Sat, 12 Apr 2008 18:13:20 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtzi8owf9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79370>

On Saturday 12 April 2008 00:31, Junio C Hamano wrote:
> Ping Yin <pkufranky@gmail.com> writes:
> > +static void wt_status_print_submodule_summary(struct wt_status *s)
> > +{
> > ...
> > +	memset(&sm_summary, 0, sizeof(sm_summary));
> > +	sm_summary.argv = argv;
> > +	sm_summary.env = env;
> > +	sm_summary.git_cmd = 1;
> > +	sm_summary.no_stdin = 1;
> > +	fflush(s->fp);
> > +	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */
> > +	run_command(&sm_summary);
>
> I recall we had some clean-up on how file descriptors are inherited and
> duped around when run_command() runs a subprocess.  Hannes, is this dup()
> consistent with how the things ought to be these days?

Yes, this dup() is required and correct.

-- Hannes
