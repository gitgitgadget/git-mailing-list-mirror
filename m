From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Remove unused variables
Date: Tue, 22 Mar 2011 14:43:09 -0500
Message-ID: <20110322194309.GA9677@elie>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q27UG-0008FY-DM
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab1CVTnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:43:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61504 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1CVTnT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:43:19 -0400
Received: by ywj3 with SMTP id 3so3032433ywj.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 12:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z1+UfoP7MLpvmmBYqlRQF/GmKXwy4rt2vPMc1L9n6vU=;
        b=iHBZoRwWZd/zazv3XKJp4GM3YQanmhS8sQ6h3WUi3bhV0xwXSqn/N/DjpHjsPd3gpI
         nRVbjUtQqKbZtCm6qgOhI6PcOPmg6cUyYz0VvpeX7RzxurYl+s6LkV9YM7uch7VOzMy1
         YgGJvUuSaGAorLGMXVQxC6HEaUsvm13Jd1cpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FOwjyo2KXE3RxiwyLf3HBzQLZjd5LLlwh7dT2qmYPvcp9t607dQHP2tqs74b4hMyia
         J56cSeE5YH/xbRcf94k4jvkOFETjAJNZiDutKTgxs7VhGNWwXKFDHyxTtkQDSMhQwR/s
         eGUnIbbfmy3pbNN5BhQM41uDeyfMRd3MBfHbk=
Received: by 10.236.185.137 with SMTP id u9mr2362211yhm.124.1300822998371;
        Tue, 22 Mar 2011 12:43:18 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id u79sm3704104yhn.5.2011.03.22.12.43.16
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 12:43:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169770>

Hi,

These all look good.  Some notes:

Johannes Schindelin wrote:

> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -140,11 +140,10 @@ static int traverse_reachable(void)
>  	int result = 0;
>  	while (pending.nr) {
>  		struct object_array_entry *entry;
> -		struct object *obj, *parent;
> +		struct object *obj;

Cleaning up after v1.7.4.1~1^2~1 (fsck: drop unused parameter from
traverse_one_object(), 2011-01-26).  Sensible.

> --- a/builtin/remote-ext.c
> +++ b/builtin/remote-ext.c
> @@ -30,16 +30,12 @@ static char *strip_escapes(const char *str, const char *service,
>  	size_t rpos = 0;
>  	int escape = 0;
>  	char special = 0;
> -	size_t pslen = 0;
> -	size_t pSlen = 0;

These were never used; sorry to have missed it before.

> --- a/diff.c
> +++ b/diff.c
> @@ -1242,7 +1242,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	uintmax_t max_change = 0, max_len = 0;
>  	int total_files = data->nr;
>  	int width, name_width;
> -	const char *reset, *set, *add_c, *del_c;
> +	const char *reset, *add_c, *del_c;

After v1.6.4-rc0~159^2 (diff: do not color --stat output like patch
context, 2009-04-25), the "patch context" color is not used in
diffstats.

> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -357,7 +357,6 @@ static void make_room_for_directories_of_df_conflicts(struct merge_options *o,
>  	 */
>  	const char *last_file = NULL;
>  	int last_len = 0;
> -	struct stage_data *last_e;

Yep, was never used (and while the code to set it is correct, it
is better to remove it than to let it bitrot).

> @@ -969,7 +967,6 @@ static int process_renames(struct merge_options *o,
>  	}
>  
>  	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
> -		char *src;

Likewise.

> --- a/reachable.c
> +++ b/reachable.c
> @@ -70,16 +70,11 @@ static void process_tree(struct tree *tree,
>  static void process_tag(struct tag *tag, struct object_array *p, const char *name)
>  {
>  	struct object *obj = &tag->object;
> -	struct name_path me;
>  
>  	if (obj->flags & SEEN)
>  		return;
>  	obj->flags |= SEEN;
>  
> -	me.up = NULL;
> -	me.elem = "tag:/";
> -	me.elem_len = 5;
> -
>  	if (parse_tag(tag) < 0)
>  		die("bad tag object %s", sha1_to_hex(obj->sha1));
>  	if (tag->tagged)

Does this code make sense at all?  It peels a tag once in order to
mark the object it refers to with "add_object", which adds the object
to the array referred to by "p", that nobody actually uses.  Maybe
this is a remnant of an earlier implementation for "git log
--objects"?

Peeling of tags is already taken care of by revision::handle_commit,
so I think the function could be stripped down to

 static void process_tag(struct tag *tag, struct object_array *p, const char *name)
 {
	struct object *obj = &tag->object;
 
	if (obj->flags & SEEN)
		return;
	obj->flags |= SEEN;
 }

which seems to work okay still.

> --- a/test-subprocess.c
> +++ b/test-subprocess.c
> @@ -3,11 +3,10 @@
[...]
> -	prefix = setup_git_directory_gently(&nogit);
> +	setup_git_directory_gently(&nogit);

It might be more idiomatic to use setup_git_directory, but this is
better because conservative.

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -561,10 +561,9 @@ static int push_refs_with_push(struct transport *transport,
>  	int mirror = flags & TRANSPORT_PUSH_MIRROR;
>  	struct helper_data *data = transport->data;
>  	struct strbuf buf = STRBUF_INIT;
> -	struct child_process *helper;

Cleaning up after v1.7.0-rc0~62^2~12 (Add remote helper debug mode,
2009-12-09).  The remote helper process is accessed through
transport->data->helper.

Thanks and hope that helps.
Jonathan
