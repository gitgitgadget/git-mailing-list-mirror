From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Tue, 12 May 2015 19:29:01 +0200
Message-ID: <5552385D.1050303@kdbg.org>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com> <1431384645-17276-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: dturner@twopensource.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:29:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsDzi-00028b-LW
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbbELR3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:29:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:63502 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932918AbbELR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:29:06 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lmR254LpFz5tlH;
	Tue, 12 May 2015 19:29:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3651E2A9E;
	Tue, 12 May 2015 19:29:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1431384645-17276-2-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268860>

Am 12.05.2015 um 00:50 schrieb dturner@twopensource.com:
> +		} else if (S_ISLNK(*mode)) {
> +			/* Follow a symlink */
> +			size_t link_len, len;
> +			char *contents, *contents_start;
> +			struct dir_state *parent;
> +			enum object_type type;
> +
> +			if (follows_remaining-- == 0)
> +				/* Too many symlinks followed */
> +				goto done;
> +
> +			contents = read_sha1_file(current_tree_sha1, &type,
> +						  &link_len);

In this line, I get:

tree-walk.c: In function 'get_tree_entry_follow_symlinks':
tree-walk.c:637: warning: passing argument 3 of 'read_sha1_file' from 
incompatible pointer type
cache.h:885: note: expected 'long unsigned int *' but argument is of 
type 'size_t *'

-- Hannes
