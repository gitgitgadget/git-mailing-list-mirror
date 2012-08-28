From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 09/16] Allow reading svn dumps from files via file://
 urls
Date: Tue, 28 Aug 2012 10:06:20 -0700
Message-ID: <7vd32a3nee.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:03:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q7u-0003bZ-Px
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402Ab2H1SCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:02:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2H1SCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:02:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69026920C;
	Tue, 28 Aug 2012 14:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=pjpm5BvMKWFHVXR2f/P527DBkHQ=; b=i/IgVkOOStz8Faj+2Mlq
	wtaLAWhNWQ3RhpNpCCMl2ySiiQiIO/KZZvzFmdpU+j/ZsW7an8EeVOG/zb3ugeAV
	2r799wGrWELgP5goRn5nveXzU2NcYtXUoEYndnUojf2qs4NQP0sShI8R/nmiQwnu
	mm9oxQJT6D2nLcx8OVVuJFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eFxdVCg5CGxKcLDvcAg8Ha/fXoq3nxtaH/LoJTduFTr7yx
	WTUpC5qxt5+NRxJkUt+iiLMFqwQzmRFSyKB73GvNfiPF6AWyJaVUypo+JF6+aIe8
	mJ7EEJP07ow2ZgoK5Odv6yeJAXo6iri8Z77U22N2VyKz64nGprmzUw1FHlurU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56DF2920B;
	Tue, 28 Aug 2012 14:02:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 898529208; Tue, 28 Aug 2012
 14:02:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94E12C80-F13A-11E1-B777-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204438>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> For testing as well as for importing large, already available dumps,
> it's useful to bypass svnrdump and replay the svndump from a file
> directly.
>
> Add support for file:// urls in the remote url, e.g.
>
>   svn::file:///path/to/dump
>
> When the remote helper finds an url starting with file:// it tries to
> open that file instead of invoking svnrdump.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote-testsvn.c |   55 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index ebe803b..2b9d151 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -9,6 +9,7 @@
>  #include "argv-array.h"
>  
>  static const char *url;
> +static int dump_from_file;
>  static const char *private_ref;
>  static const char *remote_ref = "refs/heads/master";
>  
> @@ -53,29 +54,38 @@ static int cmd_import(const char *line)
>  	struct argv_array svndump_argv = ARGV_ARRAY_INIT;
>  	struct child_process svndump_proc;
>  
> -	memset(&svndump_proc, 0, sizeof(struct child_process));
> -	svndump_proc.out = -1;
> -	argv_array_push(&svndump_argv, "svnrdump");
> -	argv_array_push(&svndump_argv, "dump");
> -	argv_array_push(&svndump_argv, url);
> -	argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> -	svndump_proc.argv = svndump_argv.argv;
> -
> -	code = start_command(&svndump_proc);
> -	if (code)
> -		die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> -	dumpin_fd = svndump_proc.out;
> -
> +	if (dump_from_file) {
> +		dumpin_fd = open(url, O_RDONLY);
> +		if(dumpin_fd < 0) {
> +			die_errno("Couldn't open svn dump file %s.", url);
> +		}
> +	}
> +	else {
> +		memset(&svndump_proc, 0, sizeof(struct child_process));


Style:

	if (dump_from_file) {
		dumpin_fd = open(url, O_RDONLY);
		if (dumpin_fd < 0)
                	die_errno("Couldn't...", url);
	} else {
        	memset(&svndump_proc, ...);
		...
	}

> +		svndump_proc.out = -1;
> +		argv_array_push(&svndump_argv, "svnrdump");
> +		argv_array_push(&svndump_argv, "dump");
> +		argv_array_push(&svndump_argv, url);
> +		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> +		svndump_proc.argv = svndump_argv.argv;
> +
> +		code = start_command(&svndump_proc);
> +		if (code)
> +			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> +		dumpin_fd = svndump_proc.out;
> +	}
>  	svndump_init_fd(dumpin_fd, STDIN_FILENO);
>  	svndump_read(url, private_ref);
>  	svndump_deinit();
>  	svndump_reset();
>  
>  	close(dumpin_fd);
> -	code = finish_command(&svndump_proc);
> -	if (code)
> -		warning("%s, returned %d", svndump_proc.argv[0], code);
> -	argv_array_clear(&svndump_argv);
> +	if(!dump_from_file) {

Style:

	if (!dump_from_file) {

> +		code = finish_command(&svndump_proc);
> +		if (code)
> +			warning("%s, returned %d", svndump_proc.argv[0], code);
> +		argv_array_clear(&svndump_argv);
> +	}
>  
>  	return 0;
>  }
> @@ -149,8 +159,15 @@ int main(int argc, const char **argv)
>  	remote = remote_get(argv[1]);
>  	url_in = (argc == 3) ? argv[2] : remote->url[0];
>  
> -	end_url_with_slash(&buf, url_in);
> -	url = strbuf_detach(&buf, NULL);
> +	if (!prefixcmp(url_in, "file://")) {
> +		dump_from_file = 1;
> +		url = url_decode(url_in + sizeof("file://")-1);
> +	}
> +	else {

Style:

	if (...) {
		...
        } else {
		...
	}

> +		dump_from_file = 0;
> +		end_url_with_slash(&buf, url_in);
> +		url = strbuf_detach(&buf, NULL);
> +	}
>  
>  	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
>  	private_ref = strbuf_detach(&buf, NULL);
