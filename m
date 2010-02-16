From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv13 28/30] builtin-notes: Add -c/-C options for reusing notes
Date: Tue, 16 Feb 2010 02:47:49 +0100
Message-ID: <201002160247.49719.johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
 <1266096518-2104-29-git-send-email-johan@herland.net>
 <4B792347.8070208@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhCXx-0008Vm-Hb
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 02:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483Ab0BPBsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 20:48:05 -0500
Received: from smtp.getmail.no ([84.208.15.66]:34834 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443Ab0BPBsD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 20:48:03 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXW00H4EVO02UB0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Feb 2010 02:48:00 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXW00K58VNQLY20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 16 Feb 2010 02:48:00 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.16.13325
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <4B792347.8070208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140056>

On Monday 15 February 2010, Stephen Boyd wrote:
> On 02/13/2010 01:28 PM, Johan Herland wrote:
> > @@ -199,6 +203,40 @@ static int parse_file_arg(const struct option
> > *opt, const char *arg, int unset)
> > 
> >  	return 0;
> >  
> >  }
> > 
> > +static int parse_reuse_arg(const struct option *opt, const char *arg,
> > int unset) +{
> > +	struct msg_arg *msg = opt->value;
> > +	char *buf;
> > +	unsigned char object[20];
> > +	enum object_type type;
> > +	unsigned long len;
> > +
> > +	if (!arg)
> > +		return -1;
> 
> This is impossible unless you're using the PARSE_OPT_OPTARG flag or
> allowing negation (i.e. --no-reuse-mesage). You should probably make the
> two callback options PARSE_OPT_NONEG and then drop this if statement.
> Same applies to some of the other callbacks not introduced in this patch.

Thanks. Fixed locally. Will be part of the next iteration.

> > +
> > +	if (msg->buf.len)
> > +		strbuf_addstr(&(msg->buf), "\n");
> > +
> 
> Use strbuf_addch()? I saw this in a couple other patches too.

Of course. Thanks for noticing. Fixed locally. Will be part of the next 
iteration.


Thanks for the review! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
