From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from
 searching for git repository
Date: Tue, 27 Oct 2009 23:11:01 -0700
Message-ID: <7viqe0yrnu.fsf@alter.siamese.dyndns.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
 <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
 <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
 <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
 <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
 <20091027133040.28836.qmail@fe20635a713ff7.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N31kf-0004HT-Hd
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 07:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397AbZJ1GLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 02:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757391AbZJ1GLL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 02:11:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211AbZJ1GLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 02:11:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC58788CF5;
	Wed, 28 Oct 2009 02:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dEZcmwKjIVZbOffHMWBcZHfVtl4=; b=GYgKKg
	42+15OgBDNkMVzCoarUDC+BXrh2dXV77OgOq1VK1f3dYKTqggXXXdi6SjHn2DHSV
	8avnOb4onI/PA9WwH/Hc5lGKLhJIbXPnXfjaAtTD/2w4U9YHyaG3os2zBlVNV+90
	U2Cp1on/ikurs4Sgt96SeiAvZ7GpbZf5WVYFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GWFi09JuK4MyQ0cCf4U/N90UzaGPrV9y
	M2NYU8E8xfW7TIf5reLQU8A4Ajd3meUCh+LPqMmLc1Cx7SqyHtseeOU8cecCXtMy
	nCqzQ4dmOHLP+M7kVHf8Ccc92JdRMuXyyS6S9hbtV44e7OAugSE7jEKBup2yvDV7
	1amxoLb0I+U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C9DA88CF4;
	Wed, 28 Oct 2009 02:11:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33C5388CF1; Wed, 28 Oct 2009
 02:11:02 -0400 (EDT)
In-Reply-To: <20091027133040.28836.qmail@fe20635a713ff7.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Tue\, 27 Oct 2009 13\:30\:40 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0A8035E-C388-11DE-A8C5-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131408>

Gerrit Pape <pape@smarden.org> writes:

> Hi Junio, I suggest to apply this patch from Johannes to master.
>
> Thanks, Gerrit.

Could you help by coming up with a suitable log message?

It's a bit too much to ask me to hunt for ancient discussion to correct
the <<all the ack go here>> myself to describe what the issue was,
especially when I wasn't heavily involved in the review of the patch
itself.  My impression is that the original description of the problem 
and the solution in your first message does not apply to what Dscho and
you agreed to be the best solution.

>
> On Fri, Sep 04, 2009 at 11:09:36AM +0000, Gerrit Pape wrote:
>> On Fri, Sep 04, 2009 at 12:22:36PM +0200, Johannes Schindelin wrote:
>> > -- snipsnap --
>> > [PATCH] git help -a: do not look for a repository
>> 
>> Perfect, thanks.
>> 
>> Acked-by: Gerrit Pape <pape@smarden.org>
>> 
>> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > 
>> > ---
>> > 
>> >  builtin-help.c |    6 +++---
>> >  1 files changed, 3 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/builtin-help.c b/builtin-help.c
>> > index e1eba77..719aa23 100644
>> > --- a/builtin-help.c
>> > +++ b/builtin-help.c
>> > @@ -416,9 +416,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>> >  	const char *alias;
>> >  	load_command_list("git-", &main_cmds, &other_cmds);
>> >  
>> > -	setup_git_directory_gently(&nongit);
>> > -	git_config(git_help_config, NULL);
>> > -
>> >  	argc = parse_options(argc, argv, prefix, builtin_help_options,
>> >  			builtin_help_usage, 0);
>> >  
>> > @@ -429,6 +426,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>> >  		return 0;
>> >  	}
>> >  
>> > +	setup_git_directory_gently(&nongit);
>> > +	git_config(git_help_config, NULL);
>> > +
>> >  	if (!argv[0]) {
>> >  		printf("usage: %s\n\n", git_usage_string);
>> >  		list_common_cmds_help();
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe git" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
