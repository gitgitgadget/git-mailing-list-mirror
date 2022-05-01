Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A9C433EF
	for <git@archiver.kernel.org>; Sun,  1 May 2022 17:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbiEARHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiEARHn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 13:07:43 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AB434AB
        for <git@vger.kernel.org>; Sun,  1 May 2022 10:04:14 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e5ca5c580fso12556315fac.3
        for <git@vger.kernel.org>; Sun, 01 May 2022 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMsO01gBkXqpdeuDPN2IUALRZqVATSdBxXiu8oFIg6g=;
        b=FsNDFqaid/E+Ub4nftZSCBlTUNgygvi9U3jpJKUG/gmAk1g1uEozLH8zGugnud+b62
         tbevJrKyJCmGXX/2hAvCiFUz3eta68L9iiRWvKkSjN1v+/jbbgQXmJV9B5UKHd+pUn/w
         z3/++YEIsX5c8UfNXv2n2eqTbLn1bPHc4QPLuphraqazbpxAMtVevibsUvgCvANVbpY+
         9SJRaA87ULDOR3insCCv795UD3V6esi7foDrsMPjLeli8iCemM+sOlJx/nSC8Z9JY3pP
         LthYTf1TOpRtqP3uRo6BDRoqzSJGnT6gMpJKQK3FNCAgbkB18ovuzGCeGaa63kCQtffg
         +zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMsO01gBkXqpdeuDPN2IUALRZqVATSdBxXiu8oFIg6g=;
        b=fbnO3Uv4mDQfwOH6+gbmxbDHSm3JdUiQLOGqH9RJMD7Q+FEimDwv2tvHbZk51UJcEc
         hsQvTfsie65cuzv+nl9cAND2Z78H4QbbNt4uGFAXu5DFAtV+AKWysMKadsWK3W0L2GON
         hsjQogBIHL7KXw6dF1TgIyumnunKHxJGJLsFBzIVa4RTTtBJB3TMvZL8zWS5uvNTMw+u
         PrNR2OZIM5ZsX5GmY0gYWAEXUmAB5PMfHpSWumPRfSdIYMREgIFkiyNWaEyJSdl5enPB
         Bxjsn1ZewaKv7FcoYZHB5YGu5s0dV/lUwQPE1Ba5GBsysxuCxwJyAfgnuLYBU5SyLT96
         tAWA==
X-Gm-Message-State: AOAM531/o/Q+fxKkwpTXYh4+PzDacoWOvCC+VbjmxLecvd3FTi2mbzkY
        DPf4M78jOuqgeOQFVDL6W/hbeDX8/dnyASkns7Qam47O
X-Google-Smtp-Source: ABdhPJz7Oz5IQpusHw4hHgBX3vo3bAXjF+0ZyZTSoXW/7TcvwVDGsCvBQ9uWgEObaSrFFnc1Vi/lwj1ZpFDps/l2HtM=
X-Received: by 2002:a05:6870:d0cc:b0:ec:d78e:1df1 with SMTP id
 k12-20020a056870d0cc00b000ecd78e1df1mr3045031oaa.197.1651424653681; Sun, 01
 May 2022 10:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com> <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
 <xmqqpmky70jb.fsf@gitster.g> <a3e06290-052e-af36-4170-301e567d561d@iee.email>
 <xmqqr15e5fm3.fsf@gitster.g> <xmqqmtg25cjw.fsf@gitster.g>
In-Reply-To: <xmqqmtg25cjw.fsf@gitster.g>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Sun, 1 May 2022 19:04:06 +0200
Message-ID: <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno dom 1 mag 2022 alle ore 02:20 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> What I found curious is that the result of applying these patches to
> v2.36.0 and running coccicheck reveals that we are not making the
> codebase clean wrt this new coccinelle rule.
>
It is possible, I did not use coccicheck to apply the semantic patch
(on next)  but i use a my script which I think is slightly more
efficient but perhaps it is not so correct. Anyway, given the
discussion that has taken place so far, what do you think is best for
me to do? Do a reroll (perhaps with only 2 patches in total ) or wait
for the "right" moment in the future as foreseen by the Documentation
and dedicate the time to more useful contributions for git? Thank you
all for the review

>


>
> diff -u -p a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -342,7 +342,7 @@ int fsm_listen__ctor(struct fsmonitor_da
>                                            data->cfar_paths_to_watch,
>                                            kFSEventStreamEventIdSinceNow,
>                                            0.001, flags);
> -       if (data->stream == NULL)
> +       if (!data->stream)
>                 goto failed;
>
>         /*
> diff -u -p a/compat/mingw.c b/compat/mingw.c
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1060,7 +1060,7 @@ char *mingw_mktemp(char *template)
>  int mkstemp(char *template)
>  {
>         char *filename = mktemp(template);
> -       if (filename == NULL)
> +       if (!filename)
>                 return -1;
>         return open(filename, O_RDWR | O_CREAT, 0600);
>  }
> @@ -2332,7 +2332,7 @@ int setitimer(int type, struct itimerval
>         static const struct timeval zero;
>         static int atexit_done;
>
> -       if (out != NULL)
> +       if (out)
>                 return errno = EINVAL,
>                         error("setitimer param 3 != NULL not implemented");
>         if (!is_timeval_eq(&in->it_interval, &zero) &&
> @@ -2361,7 +2361,7 @@ int sigaction(int sig, struct sigaction
>         if (sig != SIGALRM)
>                 return errno = EINVAL,
>                         error("sigaction only implemented for SIGALRM");
> -       if (out != NULL)
> +       if (out)
>                 return errno = EINVAL,
>                         error("sigaction: param 3 != NULL not implemented");
>
> diff -u -p a/compat/mkdir.c b/compat/mkdir.c
> --- a/compat/mkdir.c
> +++ b/compat/mkdir.c
> @@ -9,7 +9,7 @@ int compat_mkdir_wo_trailing_slash(const
>         size_t len = strlen(dir);
>
>         if (len && dir[len-1] == '/') {
> -               if ((tmp_dir = strdup(dir)) == NULL)
> +               if (!(tmp_dir = strdup(dir)))
>                         return -1;
>                 tmp_dir[len-1] = '\0';
>         }
> diff -u -p a/compat/mmap.c b/compat/mmap.c
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -13,7 +13,7 @@ void *git_mmap(void *start, size_t lengt
>         }
>
>         start = malloc(length);
> -       if (start == NULL) {
> +       if (!start) {
>                 errno = ENOMEM;
>                 return MAP_FAILED;
>         }
> diff -u -p a/compat/mingw.c b/compat/mingw.c
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1060,7 +1060,7 @@ char *mingw_mktemp(char *template)
>  int mkstemp(char *template)
>  {
>         char *filename = mktemp(template);
> -       if (filename == NULL)
> +       if (!filename)
>                 return -1;
>         return open(filename, O_RDWR | O_CREAT, 0600);
>  }
> @@ -2332,7 +2332,7 @@ int setitimer(int type, struct itimerval
>         static const struct timeval zero;
>         static int atexit_done;
>
> -       if (out != NULL)
> +       if (out)
>                 return errno = EINVAL,
>                         error("setitimer param 3 != NULL not implemented");
>         if (!is_timeval_eq(&in->it_interval, &zero) &&
> @@ -2361,7 +2361,7 @@ int sigaction(int sig, struct sigaction
>         if (sig != SIGALRM)
>                 return errno = EINVAL,
>                         error("sigaction only implemented for SIGALRM");
> -       if (out != NULL)
> +       if (out)
>                 return errno = EINVAL,
>                         error("sigaction: param 3 != NULL not implemented");
>
> diff -u -p a/config.c b/config.c
> --- a/config.c
> +++ b/config.c
> @@ -3190,7 +3190,7 @@ int git_config_set_multivar_in_file_gent
>                         goto out_free;
>                 }
>                 /* if nothing to unset, error out */
> -               if (value == NULL) {
> +               if (!value) {
>                         ret = CONFIG_NOTHING_SET;
>                         goto out_free;
>                 }
> @@ -3206,7 +3206,7 @@ int git_config_set_multivar_in_file_gent
>                 int i, new_line = 0;
>                 struct config_options opts;
>
> -               if (value_pattern == NULL)
> +               if (!value_pattern)
>                         store.value_pattern = NULL;
>                 else if (value_pattern == CONFIG_REGEX_NONE)
>                         store.value_pattern = CONFIG_REGEX_NONE;
> @@ -3346,7 +3346,7 @@ int git_config_set_multivar_in_file_gent
>                 }
>
>                 /* write the pair (value == NULL means unset) */
> -               if (value != NULL) {
> +               if (value) {
>                         if (!store.section_seen) {
>                                 if (write_section(fd, key, &store) < 0)
>                                         goto write_err_out;
> @@ -3567,7 +3567,7 @@ static int git_config_copy_or_rename_sec
>                         offset = section_name_match(&buf[i], old_name);
>                         if (offset > 0) {
>                                 ret++;
> -                               if (new_name == NULL) {
> +                               if (!new_name) {
>                                         remove = 1;
>                                         continue;
>                                 }
> diff -u -p a/daemon.c b/daemon.c
> --- a/daemon.c
> +++ b/daemon.c
> @@ -447,7 +447,7 @@ static void copy_to_log(int fd)
>         FILE *fp;
>
>         fp = fdopen(fd, "r");
> -       if (fp == NULL) {
> +       if (!fp) {
>                 logerror("fdopen of error channel failed");
>                 close(fd);
>                 return;
> diff -u -p a/dir.c b/dir.c
> --- a/dir.c
> +++ b/dir.c
> @@ -3054,7 +3054,7 @@ char *git_url_basename(const char *repo,
>          * Skip scheme.
>          */
>         start = strstr(repo, "://");
> -       if (start == NULL)
> +       if (!start)
>                 start = repo;
>         else
>                 start += 3;
> diff -u -p a/ewah/bitmap.c b/ewah/bitmap.c
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -223,7 +223,7 @@ void bitmap_reset(struct bitmap *bitmap)
>
>  void bitmap_free(struct bitmap *bitmap)
>  {
> -       if (bitmap == NULL)
> +       if (!bitmap)
>                 return;
>
>         free(bitmap->words);
> diff -u -p a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -451,7 +451,7 @@ struct ewah_bitmap *ewah_pool_new(void)
>
>  void ewah_pool_free(struct ewah_bitmap *self)
>  {
> -       if (self == NULL)
> +       if (!self)
>                 return;
>
>         if (bitmap_pool_size == BITMAP_POOL_MAX ||
> diff -u -p a/http-fetch.c b/http-fetch.c
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -55,7 +55,7 @@ static void fetch_single_packfile(struct
>         http_init(NULL, url, 0);
>
>         preq = new_direct_http_pack_request(packfile_hash->hash, xstrdup(url));
> -       if (preq == NULL)
> +       if (!preq)
>                 die("couldn't create http pack request");
>         preq->slot->results = &results;
>         preq->index_pack_args = index_pack_args;
> diff -u -p a/http-push.c b/http-push.c
> --- a/http-push.c
> +++ b/http-push.c
> @@ -253,7 +253,7 @@ static void start_fetch_loose(struct tra
>         struct http_object_request *obj_req;
>
>         obj_req = new_http_object_request(repo->url, &request->obj->oid);
> -       if (obj_req == NULL) {
> +       if (!obj_req) {
>                 request->state = ABORTED;
>                 return;
>         }
> @@ -318,7 +318,7 @@ static void start_fetch_packed(struct tr
>         fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
>
>         preq = new_http_pack_request(target->hash, repo->url);
> -       if (preq == NULL) {
> +       if (!preq) {
>                 repo->can_update_info_refs = 0;
>                 return;
>         }
> @@ -520,7 +520,7 @@ static void finish_request(struct transf
>         /* Keep locks active */
>         check_locks();
>
> -       if (request->headers != NULL)
> +       if (request->headers)
>                 curl_slist_free_all(request->headers);
>
>         /* URL is reused for MOVE after PUT and used during FETCH */
> @@ -783,7 +783,7 @@ xml_start_tag(void *userData, const char
>         const char *c = strchr(name, ':');
>         int old_namelen, new_len;
>
> -       if (c == NULL)
> +       if (!c)
>                 c = name;
>         else
>                 c++;
> @@ -811,7 +811,7 @@ xml_end_tag(void *userData, const char *
>
>         ctx->userFunc(ctx, 1);
>
> -       if (c == NULL)
> +       if (!c)
>                 c = name;
>         else
>                 c++;
> @@ -1893,7 +1893,7 @@ int cmd_main(int argc, const char **argv
>
>                 /* Lock remote branch ref */
>                 ref_lock = lock_remote(ref->name, LOCK_TIME);
> -               if (ref_lock == NULL) {
> +               if (!ref_lock) {
>                         fprintf(stderr, "Unable to lock remote branch %s\n",
>                                 ref->name);
>                         if (helper_status)
> diff -u -p a/http-walker.c b/http-walker.c
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -59,7 +59,7 @@ static void start_object_request(struct
>         struct http_object_request *req;
>
>         req = new_http_object_request(obj_req->repo->base, &obj_req->oid);
> -       if (req == NULL) {
> +       if (!req) {
>                 obj_req->state = ABORTED;
>                 return;
>         }
> @@ -106,7 +106,7 @@ static void process_object_response(void
>         /* Use alternates if necessary */
>         if (missing_target(obj_req->req)) {
>                 fetch_alternates(walker, alt->base);
> -               if (obj_req->repo->next != NULL) {
> +               if (obj_req->repo->next) {
>                         obj_req->repo =
>                                 obj_req->repo->next;
>                         release_http_object_request(obj_req->req);
> @@ -225,12 +225,12 @@ static void process_alternates_response(
>                                          alt_req->url->buf);
>                         active_requests++;
>                         slot->in_use = 1;
> -                       if (slot->finished != NULL)
> +                       if (slot->finished)
>                                 (*slot->finished) = 0;
>                         if (!start_active_slot(slot)) {
>                                 cdata->got_alternates = -1;
>                                 slot->in_use = 0;
> -                               if (slot->finished != NULL)
> +                               if (slot->finished)
>                                         (*slot->finished) = 1;
>                         }
>                         return;
> @@ -443,7 +443,7 @@ static int http_fetch_pack(struct walker
>         }
>
>         preq = new_http_pack_request(target->hash, repo->base);
> -       if (preq == NULL)
> +       if (!preq)
>                 goto abort;
>         preq->slot->results = &results;
>
> @@ -489,11 +489,11 @@ static int fetch_object(struct walker *w
>                 if (hasheq(obj_req->oid.hash, hash))
>                         break;
>         }
> -       if (obj_req == NULL)
> +       if (!obj_req)
>                 return error("Couldn't find request for %s in the queue", hex);
>
>         if (has_object_file(&obj_req->oid)) {
> -               if (obj_req->req != NULL)
> +               if (obj_req->req)
>                         abort_http_object_request(obj_req->req);
>                 abort_object_request(obj_req);
>                 return 0;
> diff -u -p a/http.c b/http.c
> --- a/http.c
> +++ b/http.c
> @@ -197,11 +197,11 @@ static void finish_active_slot(struct ac
>         closedown_active_slot(slot);
>         curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
>
> -       if (slot->finished != NULL)
> +       if (slot->finished)
>                 (*slot->finished) = 1;
>
>         /* Store slot results so they can be read after the slot is reused */
> -       if (slot->results != NULL) {
> +       if (slot->results) {
>                 slot->results->curl_result = slot->curl_result;
>                 slot->results->http_code = slot->http_code;
>                 curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
> @@ -212,7 +212,7 @@ static void finish_active_slot(struct ac
>         }
>
>         /* Run callback if appropriate */
> -       if (slot->callback_func != NULL)
> +       if (slot->callback_func)
>                 slot->callback_func(slot->callback_data);
>  }
>
> @@ -234,7 +234,7 @@ static void process_curl_messages(void)
>                         while (slot != NULL &&
>                                slot->curl != curl_message->easy_handle)
>                                 slot = slot->next;
> -                       if (slot != NULL) {
> +                       if (slot) {
>                                 xmulti_remove_handle(slot);
>                                 slot->curl_result = curl_result;
>                                 finish_active_slot(slot);
> @@ -838,16 +838,16 @@ static CURL *get_curl_handle(void)
>                 curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>                                 ssl_cipherlist);
>
> -       if (ssl_cert != NULL)
> +       if (ssl_cert)
>                 curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>         if (has_cert_password())
>                 curl_easy_setopt(result, CURLOPT_KEYPASSWD, cert_auth.password);
> -       if (ssl_key != NULL)
> +       if (ssl_key)
>                 curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
> -       if (ssl_capath != NULL)
> +       if (ssl_capath)
>                 curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
>  #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
> -       if (ssl_pinnedkey != NULL)
> +       if (ssl_pinnedkey)
>                 curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
>  #endif
>         if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
> @@ -857,10 +857,10 @@ static CURL *get_curl_handle(void)
>                 curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, NULL);
>  #endif
>         } else if (ssl_cainfo != NULL || http_proxy_ssl_ca_info != NULL) {
> -               if (ssl_cainfo != NULL)
> +               if (ssl_cainfo)
>                         curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
>  #ifdef GIT_CURL_HAVE_CURLOPT_PROXY_CAINFO
> -               if (http_proxy_ssl_ca_info != NULL)
> +               if (http_proxy_ssl_ca_info)
>                         curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
>  #endif
>         }
> @@ -1050,7 +1050,7 @@ void http_init(struct remote *remote, co
>
>         {
>                 char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
> -               if (http_max_requests != NULL)
> +               if (http_max_requests)
>                         max_requests = atoi(http_max_requests);
>         }
>
> @@ -1069,10 +1069,10 @@ void http_init(struct remote *remote, co
>         set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
>
>         low_speed_limit = getenv("GIT_HTTP_LOW_SPEED_LIMIT");
> -       if (low_speed_limit != NULL)
> +       if (low_speed_limit)
>                 curl_low_speed_limit = strtol(low_speed_limit, NULL, 10);
>         low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
> -       if (low_speed_time != NULL)
> +       if (low_speed_time)
>                 curl_low_speed_time = strtol(low_speed_time, NULL, 10);
>
>         if (curl_ssl_verify == -1)
> @@ -1109,7 +1109,7 @@ void http_cleanup(void)
>
>         while (slot != NULL) {
>                 struct active_request_slot *next = slot->next;
> -               if (slot->curl != NULL) {
> +               if (slot->curl) {
>                         xmulti_remove_handle(slot);
>                         curl_easy_cleanup(slot->curl);
>                 }
> @@ -1147,13 +1147,13 @@ void http_cleanup(void)
>         free((void *)http_proxy_authmethod);
>         http_proxy_authmethod = NULL;
>
> -       if (cert_auth.password != NULL) {
> +       if (cert_auth.password) {
>                 memset(cert_auth.password, 0, strlen(cert_auth.password));
>                 FREE_AND_NULL(cert_auth.password);
>         }
>         ssl_cert_password_required = 0;
>
> -       if (proxy_cert_auth.password != NULL) {
> +       if (proxy_cert_auth.password) {
>                 memset(proxy_cert_auth.password, 0, strlen(proxy_cert_auth.password));
>                 FREE_AND_NULL(proxy_cert_auth.password);
>         }
> @@ -1179,14 +1179,14 @@ struct active_request_slot *get_active_s
>         while (slot != NULL && slot->in_use)
>                 slot = slot->next;
>
> -       if (slot == NULL) {
> +       if (!slot) {
>                 newslot = xmalloc(sizeof(*newslot));
>                 newslot->curl = NULL;
>                 newslot->in_use = 0;
>                 newslot->next = NULL;
>
>                 slot = active_queue_head;
> -               if (slot == NULL) {
> +               if (!slot) {
>                         active_queue_head = newslot;
>                 } else {
>                         while (slot->next != NULL)
> @@ -1196,7 +1196,7 @@ struct active_request_slot *get_active_s
>                 slot = newslot;
>         }
>
> -       if (slot->curl == NULL) {
> +       if (!slot->curl) {
>                 slot->curl = curl_easy_duphandle(curl_default);
>                 curl_session_count++;
>         }
> @@ -1768,7 +1768,7 @@ static int http_request(const char *url,
>         slot = get_active_slot();
>         curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>
> -       if (result == NULL) {
> +       if (!result) {
>                 curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
>         } else {
>                 curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> @@ -2100,7 +2100,7 @@ cleanup:
>
>  void release_http_pack_request(struct http_pack_request *preq)
>  {
> -       if (preq->packfile != NULL) {
> +       if (preq->packfile) {
>                 fclose(preq->packfile);
>                 preq->packfile = NULL;
>         }
> @@ -2391,7 +2391,7 @@ abort:
>
>  void process_http_object_request(struct http_object_request *freq)
>  {
> -       if (freq->slot == NULL)
> +       if (!freq->slot)
>                 return;
>         freq->curl_result = freq->slot->curl_result;
>         freq->http_code = freq->slot->http_code;
> @@ -2448,7 +2448,7 @@ void release_http_object_request(struct
>                 freq->localfile = -1;
>         }
>         FREE_AND_NULL(freq->url);
> -       if (freq->slot != NULL) {
> +       if (freq->slot) {
>                 freq->slot->callback_func = NULL;
>                 freq->slot->callback_data = NULL;
>                 release_active_slot(freq->slot);
> diff -u -p a/kwset.c b/kwset.c
> --- a/kwset.c
> +++ b/kwset.c
> @@ -477,7 +477,7 @@ kwsprep (kwset_t kws)
>         next[i] = NULL;
>        treenext(kwset->trie->links, next);
>
> -      if ((trans = kwset->trans) != NULL)
> +      if ((trans = kwset->trans))
>         for (i = 0; i < NCHAR; ++i)
>           kwset->next[i] = next[U(trans[i])];
>        else
> @@ -485,7 +485,7 @@ kwsprep (kwset_t kws)
>      }
>
>    /* Fix things up for any translation table. */
> -  if ((trans = kwset->trans) != NULL)
> +  if ((trans = kwset->trans))
>      for (i = 0; i < NCHAR; ++i)
>        kwset->delta[i] = delta[U(trans[i])];
>    else
> diff -u -p a/ll-merge.c b/ll-merge.c
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -207,7 +207,7 @@ static enum ll_merge_result ll_ext_merge
>         dict[4].placeholder = "P"; dict[4].value = path_sq.buf;
>         dict[5].placeholder = NULL; dict[5].value = NULL;
>
> -       if (fn->cmdline == NULL)
> +       if (!fn->cmdline)
>                 die("custom merge driver %s lacks command line.", fn->name);
>
>         result->ptr = NULL;
> diff -u -p a/log-tree.c b/log-tree.c
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -88,7 +88,7 @@ static int match_ref_pattern(const char
>                              const struct string_list_item *item)
>  {
>         int matched = 0;
> -       if (item->util == NULL) {
> +       if (!item->util) {
>                 if (!wildmatch(item->string, refname, 0))
>                         matched = 1;
>         } else {
> diff -u -p a/mailinfo.c b/mailinfo.c
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -698,7 +698,7 @@ static int is_scissors_line(const char *
>                         continue;
>                 }
>                 last_nonblank = c;
> -               if (first_nonblank == NULL)
> +               if (!first_nonblank)
>                         first_nonblank = c;
>                 if (*c == '-') {
>                         in_perforation = 1;
> @@ -1094,7 +1094,7 @@ static void handle_body(struct mailinfo
>                          */
>                         lines = strbuf_split(line, '\n');
>                         for (it = lines; (sb = *it); it++) {
> -                               if (*(it + 1) == NULL) /* The last line */
> +                               if (!*(it + 1)) /* The last line */
>                                         if (sb->buf[sb->len - 1] != '\n') {
>                                                 /* Partial line, save it for later. */
>                                                 strbuf_addbuf(&prev, sb);
> diff -u -p a/mailmap.c b/mailmap.c
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -77,7 +77,7 @@ static void add_mapping(struct string_li
>         struct mailmap_entry *me;
>         struct string_list_item *item;
>
> -       if (old_email == NULL) {
> +       if (!old_email) {
>                 old_email = new_email;
>                 new_email = NULL;
>         }
> @@ -92,7 +92,7 @@ static void add_mapping(struct string_li
>                 item->util = me;
>         }
>
> -       if (old_name == NULL) {
> +       if (!old_name) {
>                 debug_mm("mailmap: adding (simple) entry for '%s'\n", old_email);
>
>                 /* Replace current name and new email for simple entry */
> @@ -123,9 +123,9 @@ static char *parse_name_and_email(char *
>         char *left, *right, *nstart, *nend;
>         *name = *email = NULL;
>
> -       if ((left = strchr(buffer, '<')) == NULL)
> +       if (!(left = strchr(buffer, '<')))
>                 return NULL;
> -       if ((right = strchr(left+1, '>')) == NULL)
> +       if (!(right = strchr(left + 1, '>')))
>                 return NULL;
>         if (!allow_empty_email && (left+1 == right))
>                 return NULL;
> @@ -153,7 +153,7 @@ static void read_mailmap_line(struct str
>         if (buffer[0] == '#')
>                 return;
>
> -       if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)) != NULL)
> +       if ((name2 = parse_name_and_email(buffer, &name1, &email1, 0)))
>                 parse_name_and_email(name2, &name2, &email2, 1);
>
>         if (email1)
> @@ -320,7 +320,7 @@ int map_user(struct string_list *map,
>                  (int)*emaillen, debug_str(*email));
>
>         item = lookup_prefix(map, *email, *emaillen);
> -       if (item != NULL) {
> +       if (item) {
>                 me = (struct mailmap_entry *)item->util;
>                 if (me->namemap.nr) {
>                         /*
> @@ -334,7 +334,7 @@ int map_user(struct string_list *map,
>                                 item = subitem;
>                 }
>         }
> -       if (item != NULL) {
> +       if (item) {
>                 struct mailmap_info *mi = (struct mailmap_info *)item->util;
>                 if (mi->name == NULL && mi->email == NULL) {
>                         debug_mm("map_user:  -- (no simple mapping)\n");
> diff -u -p a/merge-ort.c b/merge-ort.c
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2068,7 +2068,7 @@ static char *handle_path_level_conflicts
>          * to ensure that's the case.
>          */
>         c_info = strmap_get(collisions, new_path);
> -       if (c_info == NULL)
> +       if (!c_info)
>                 BUG("c_info is NULL");
>
>         /*
> @@ -4640,7 +4640,7 @@ static void merge_ort_internal(struct me
>         }
>
>         merged_merge_bases = pop_commit(&merge_bases);
> -       if (merged_merge_bases == NULL) {
> +       if (!merged_merge_bases) {
>                 /* if there is no common ancestor, use an empty tree */
>                 struct tree *tree;
>
> diff -u -p a/merge-recursive.c b/merge-recursive.c
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -82,7 +82,7 @@ static struct dir_rename_entry *dir_rena
>  {
>         struct dir_rename_entry key;
>
> -       if (dir == NULL)
> +       if (!dir)
>                 return NULL;
>         hashmap_entry_init(&key.ent, strhash(dir));
>         key.dir = dir;
> @@ -1990,14 +1990,14 @@ static void get_renamed_dir_portion(cons
>          * renamed means the root directory can never be renamed -- because
>          * the root directory always exists).
>          */
> -       if (end_of_old == NULL)
> +       if (!end_of_old)
>                 return; /* Note: *old_dir and *new_dir are still NULL */
>
>         /*
>          * If new_path contains no directory (end_of_new is NULL), then we
>          * have a rename of old_path's directory to the root directory.
>          */
> -       if (end_of_new == NULL) {
> +       if (!end_of_new) {
>                 *old_dir = xstrndup(old_path, end_of_old - old_path);
>                 *new_dir = xstrdup("");
>                 return;
> @@ -2116,7 +2116,7 @@ static char *handle_path_level_conflicts
>          * to ensure that's the case.
>          */
>         collision_ent = collision_find_entry(collisions, new_path);
> -       if (collision_ent == NULL)
> +       if (!collision_ent)
>                 BUG("collision_ent is NULL");
>
>         /*
> @@ -2996,7 +2996,7 @@ static void final_cleanup_rename(struct
>         const struct rename *re;
>         int i;
>
> -       if (rename == NULL)
> +       if (!rename)
>                 return;
>
>         for (i = 0; i < rename->nr; i++) {
> @@ -3605,7 +3605,7 @@ static int merge_recursive_internal(stru
>         }
>
>         merged_merge_bases = pop_commit(&merge_bases);
> -       if (merged_merge_bases == NULL) {
> +       if (!merged_merge_bases) {
>                 /* if there is no common ancestor, use an empty tree */
>                 struct tree *tree;
>
> diff -u -p a/object-file.c b/object-file.c
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1728,7 +1728,7 @@ void *read_object_file_extended(struct r
>                 die(_("loose object %s (stored in %s) is corrupt"),
>                     oid_to_hex(repl), path);
>
> -       if ((p = has_packed_and_bad(r, repl)) != NULL)
> +       if ((p = has_packed_and_bad(r, repl)))
>                 die(_("packed object %s (stored in %s) is corrupt"),
>                     oid_to_hex(repl), p->pack_name);
>         obj_read_unlock();
> diff -u -p a/pack-bitmap.c b/pack-bitmap.c
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -111,7 +111,7 @@ static struct ewah_bitmap *lookup_stored
>         struct ewah_bitmap *parent;
>         struct ewah_bitmap *composed;
>
> -       if (st->xor == NULL)
> +       if (!st->xor)
>                 return st->root;
>
>         composed = ewah_pool_new();
> @@ -279,7 +279,7 @@ static int load_bitmap_entries_v1(struct
>                 if (xor_offset > 0) {
>                         xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
>
> -                       if (xor_bitmap == NULL)
> +                       if (!xor_bitmap)
>                                 return error("Invalid XOR offset in bitmap pack index");
>                 }
>
> @@ -728,7 +728,7 @@ static int add_commit_to_bitmap(struct b
>         if (!or_with)
>                 return 0;
>
> -       if (*base == NULL)
> +       if (!*base)
>                 *base = ewah_to_bitmap(or_with);
>         else
>                 bitmap_or_ewah(*base, or_with);
> @@ -771,7 +771,7 @@ static struct bitmap *find_objects(struc
>          * Best case scenario: We found bitmaps for all the roots,
>          * so the resulting `or` bitmap has the full reachability analysis
>          */
> -       if (not_mapped == NULL)
> +       if (!not_mapped)
>                 return base;
>
>         roots = not_mapped;
> @@ -805,7 +805,7 @@ static struct bitmap *find_objects(struc
>                 struct include_data incdata;
>                 struct bitmap_show_data show_data;
>
> -               if (base == NULL)
> +               if (!base)
>                         base = bitmap_new();
>
>                 incdata.bitmap_git = bitmap_git;
> @@ -1299,7 +1299,7 @@ struct bitmap_index *prepare_bitmap_walk
>                 reset_revision_walk();
>                 revs->ignore_missing_links = 0;
>
> -               if (haves_bitmap == NULL)
> +               if (!haves_bitmap)
>                         BUG("failed to perform bitmap walk");
>         }
>
> @@ -1698,7 +1698,7 @@ void test_bitmap_walk(struct rev_info *r
>                 result = ewah_to_bitmap(bm);
>         }
>
> -       if (result == NULL)
> +       if (!result)
>                 die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
>
>         revs->tag_objects = 1;
> diff -u -p a/packfile.c b/packfile.c
> --- a/packfile.c
> +++ b/packfile.c
> @@ -116,7 +116,7 @@ int load_idx(const char *path, const uns
>
>         if (idx_size < 4 * 256 + hashsz + hashsz)
>                 return error("index file %s is too small", path);
> -       if (idx_map == NULL)
> +       if (!idx_map)
>                 return error("empty data");
>
>         if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
> diff -u -p a/path.c b/path.c
> --- a/path.c
> +++ b/path.c
> @@ -733,7 +733,7 @@ char *interpolate_path(const char *path,
>         struct strbuf user_path = STRBUF_INIT;
>         const char *to_copy = path;
>
> -       if (path == NULL)
> +       if (!path)
>                 goto return_null;
>
>         if (skip_prefix(path, "%(prefix)/", &path))
> diff -u -p a/prio-queue.c b/prio-queue.c
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -19,7 +19,7 @@ void prio_queue_reverse(struct prio_queu
>  {
>         int i, j;
>
> -       if (queue->compare != NULL)
> +       if (queue->compare)
>                 BUG("prio_queue_reverse() on non-LIFO queue");
>         for (i = 0; i < (j = (queue->nr - 1) - i); i++)
>                 swap(queue, i, j);
> diff -u -p a/promisor-remote.c b/promisor-remote.c
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -84,7 +84,7 @@ static void promisor_remote_move_to_tail
>                                          struct promisor_remote *r,
>                                          struct promisor_remote *previous)
>  {
> -       if (r->next == NULL)
> +       if (!r->next)
>                 return;
>
>         if (previous)
> diff -u -p a/ref-filter.c b/ref-filter.c
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1261,7 +1261,7 @@ static void grab_date(const char *buf, s
>          * ":" means no format is specified, and use the default.
>          */
>         formatp = strchr(atomname, ':');
> -       if (formatp != NULL) {
> +       if (formatp) {
>                 formatp++;
>                 parse_date_format(formatp, &date_mode);
>         }
> @@ -1509,7 +1509,7 @@ static void fill_missing_values(struct a
>         int i;
>         for (i = 0; i < used_atom_cnt; i++) {
>                 struct atom_value *v = &val[i];
> -               if (v->s == NULL)
> +               if (!v->s)
>                         v->s = xstrdup("");
>         }
>  }
> @@ -1619,7 +1619,7 @@ static const char *rstrip_ref_components
>
>         while (remaining-- > 0) {
>                 char *p = strrchr(start, '/');
> -               if (p == NULL) {
> +               if (!p) {
>                         free((char *)to_free);
>                         return xstrdup("");
>                 } else
> diff -u -p a/refs/ref-cache.c b/refs/ref-cache.c
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -134,7 +134,7 @@ int search_ref_dir(struct ref_dir *dir,
>         r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
>                     ref_entry_cmp_sslice);
>
> -       if (r == NULL)
> +       if (!r)
>                 return -1;
>
>         return r - dir->entries;
> diff -u -p a/reftable/stack_test.c b/reftable/stack_test.c
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -35,7 +35,7 @@ static int count_dir_entries(const char
>         DIR *dir = opendir(dirname);
>         int len = 0;
>         struct dirent *d;
> -       if (dir == NULL)
> +       if (!dir)
>                 return 0;
>
>         while ((d = readdir(dir))) {
> diff -u -p a/reftable/tree.c b/reftable/tree.c
> --- a/reftable/tree.c
> +++ b/reftable/tree.c
> @@ -16,7 +16,7 @@ struct tree_node *tree_search(void *key,
>                               int insert)
>  {
>         int res;
> -       if (*rootp == NULL) {
> +       if (!*rootp) {
>                 if (!insert) {
>                         return NULL;
>                 } else {
> @@ -50,7 +50,7 @@ void infix_walk(struct tree_node *t, voi
>
>  void tree_free(struct tree_node *t)
>  {
> -       if (t == NULL) {
> +       if (!t) {
>                 return;
>         }
>         if (t->left) {
> diff -u -p a/reftable/writer.c b/reftable/writer.c
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -183,7 +183,7 @@ static void writer_index_hash(struct ref
>         struct tree_node *node = tree_search(&want, &w->obj_index_tree,
>                                              &obj_index_tree_node_compare, 0);
>         struct obj_index_tree_node *key = NULL;
> -       if (node == NULL) {
> +       if (!node) {
>                 struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
>                 key = reftable_malloc(sizeof(struct obj_index_tree_node));
>                 *key = empty;
> @@ -222,7 +222,7 @@ static int writer_add_record(struct reft
>
>         strbuf_reset(&w->last_key);
>         strbuf_addbuf(&w->last_key, &key);
> -       if (w->block_writer == NULL) {
> +       if (!w->block_writer) {
>                 writer_reinit_block_writer(w, reftable_record_type(rec));
>         }
>
> @@ -263,7 +263,7 @@ int reftable_writer_add_ref(struct refta
>         };
>         int err = 0;
>
> -       if (ref->refname == NULL)
> +       if (!ref->refname)
>                 return REFTABLE_API_ERROR;
>         if (ref->update_index < w->min_update_index ||
>             ref->update_index > w->max_update_index)
> @@ -336,7 +336,7 @@ int reftable_writer_add_log(struct refta
>         if (log->value_type == REFTABLE_LOG_DELETION)
>                 return reftable_writer_add_log_verbatim(w, log);
>
> -       if (log->refname == NULL)
> +       if (!log->refname)
>                 return REFTABLE_API_ERROR;
>
>         input_log_message = log->value.update.message;
> @@ -545,7 +545,7 @@ static int writer_finish_public_section(
>         uint8_t typ = 0;
>         int err = 0;
>
> -       if (w->block_writer == NULL)
> +       if (!w->block_writer)
>                 return 0;
>
>         typ = block_writer_type(w->block_writer);
> @@ -694,7 +694,7 @@ static int writer_flush_nonempty_block(s
>
>  static int writer_flush_block(struct reftable_writer *w)
>  {
> -       if (w->block_writer == NULL)
> +       if (!w->block_writer)
>                 return 0;
>         if (w->block_writer->entries == 0)
>                 return 0;
> diff -u -p a/rerere.c b/rerere.c
> --- a/rerere.c
> +++ b/rerere.c
> @@ -591,7 +591,7 @@ int rerere_remaining(struct repository *
>                 else if (conflict_type == RESOLVED) {
>                         struct string_list_item *it;
>                         it = string_list_lookup(merge_rr, (const char *)e->name);
> -                       if (it != NULL) {
> +                       if (it) {
>                                 free_rerere_id(it);
>                                 it->util = RERERE_RESOLVED;
>                         }
> diff -u -p a/revision.c b/revision.c
> --- a/revision.c
> +++ b/revision.c
> @@ -2833,7 +2833,7 @@ int setup_revisions(int argc, const char
>         }
>         strvec_clear(&prune_data);
>
> -       if (revs->def == NULL)
> +       if (!revs->def)
>                 revs->def = opt ? opt->def : NULL;
>         if (opt && opt->tweak)
>                 opt->tweak(revs, opt);
> @@ -3652,7 +3652,7 @@ static enum rewrite_result rewrite_one_1
>                         return rewrite_one_ok;
>                 if (!p->parents)
>                         return rewrite_one_noparents;
> -               if ((p = one_relevant_parent(revs, p->parents)) == NULL)
> +               if (!(p = one_relevant_parent(revs, p->parents)))
>                         return rewrite_one_ok;
>                 *pp = p;
>         }
> diff -u -p a/setup.c b/setup.c
> --- a/setup.c
> +++ b/setup.c
> @@ -1470,7 +1470,7 @@ int git_config_perm(const char *var, con
>         int i;
>         char *endptr;
>
> -       if (value == NULL)
> +       if (!value)
>                 return PERM_GROUP;
>
>         if (!strcmp(value, "umask"))
> diff -u -p a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
> --- a/sh-i18n--envsubst.c
> +++ b/sh-i18n--envsubst.c
> @@ -397,7 +397,7 @@ subst_from_stdin (void)
>                   /* Substitute the variable's value from the environment.  */
>                   const char *env_value = getenv (buffer);
>
> -                 if (env_value != NULL)
> +                 if (env_value)
>                     fputs (env_value, stdout);
>                 }
>               else
> diff -u -p a/shallow.c b/shallow.c
> --- a/shallow.c
> +++ b/shallow.c
> @@ -560,7 +560,7 @@ static void paint_down(struct paint_info
>                 else
>                         c->object.flags |= SEEN;
>
> -               if (*refs == NULL)
> +               if (!*refs)
>                         *refs = bitmap;
>                 else {
>                         memcpy(tmp, *refs, bitmap_size);
> diff -u -p a/trailer.c b/trailer.c
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1029,7 +1029,7 @@ static FILE *create_in_place_tempfile(co
>
>         /* Create temporary file in the same directory as the original */
>         tail = strrchr(file, '/');
> -       if (tail != NULL)
> +       if (tail)
>                 strbuf_add(&filename_template, file, tail - file + 1);
>         strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
>
> diff -u -p a/transport.c b/transport.c
> --- a/transport.c
> +++ b/transport.c
> @@ -438,7 +438,7 @@ static int fetch_refs_via_pack(struct tr
>                 args.self_contained_and_connected;
>         data->options.connectivity_checked = args.connectivity_checked;
>
> -       if (refs == NULL)
> +       if (!refs)
>                 ret = -1;
>         if (report_unmatched_refs(to_fetch, nr_heads))
>                 ret = -1;
> diff -u -p a/wildmatch.c b/wildmatch.c
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -113,7 +113,7 @@ static int dowild(const uchar *p, const
>                                 /* Trailing "**" matches everything.  Trailing "*" matches
>                                  * only if there are no more slash characters. */
>                                 if (!match_slash) {
> -                                       if (strchr((char*)text, '/') != NULL)
> +                                       if (strchr((char *)text, '/'))
>                                                 return WM_NOMATCH;
>                                 }
>                                 return WM_MATCH;
> diff -u -p a/worktree.c b/worktree.c
> --- a/worktree.c
> +++ b/worktree.c
> @@ -483,7 +483,7 @@ int submodule_uses_worktrees(const char
>                 return 0;
>
>         d = readdir_skip_dot_and_dotdot(dir);
> -       if (d != NULL)
> +       if (d)
>                 ret = 1;
>         closedir(dir);
>         return ret;
> diff -u -p a/wrapper.c b/wrapper.c
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -393,7 +393,7 @@ FILE *xfopen(const char *path, const cha
>  FILE *xfdopen(int fd, const char *mode)
>  {
>         FILE *stream = fdopen(fd, mode);
> -       if (stream == NULL)
> +       if (!stream)
>                 die_errno("Out of memory? fdopen failed");
>         return stream;
>  }
> diff -u -p a/xdiff-interface.c b/xdiff-interface.c
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -159,7 +159,7 @@ int read_mmfile(mmfile_t *ptr, const cha
>
>         if (stat(filename, &st))
>                 return error_errno("Could not stat %s", filename);
> -       if ((f = fopen(filename, "rb")) == NULL)
> +       if (!(f = fopen(filename, "rb")))
>                 return error_errno("Could not open %s", filename);
>         sz = xsize_t(st.st_size);
>         ptr->ptr = xmalloc(sz ? sz : 1);
> diff -u -p a/xdiff/xemit.c b/xdiff/xemit.c
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -65,7 +65,7 @@ xdchange_t *xdl_get_hunk(xdchange_t **xs
>                         *xscr = xch;
>         }
>
> -       if (*xscr == NULL)
> +       if (!*xscr)
>                 return NULL;
>
>         lxch = *xscr;
> diff -u -p a/xdiff/xprepare.c b/xdiff/xprepare.c
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -188,7 +188,7 @@ static int xdl_prepare_ctx(unsigned int
>         memset(rhash, 0, hsize * sizeof(xrecord_t *));
>
>         nrec = 0;
> -       if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
> +       if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
>                 for (top = blk + bsize; cur < top; ) {
>                         prev = cur;
>                         hav = xdl_hash_record(&cur, top, xpp->flags);
> diff -u -p a/xdiff/xutils.c b/xdiff/xutils.c
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -122,7 +122,7 @@ long xdl_guess_lines(mmfile_t *mf, long
>         long nl = 0, size, tsize = 0;
>         char const *data, *cur, *top;
>
> -       if ((cur = data = xdl_mmfile_first(mf, &size)) != NULL) {
> +       if ((cur = data = xdl_mmfile_first(mf, &size))) {
>                 for (top = data + size; nl < sample && cur < top; ) {
>                         nl++;
>                         if (!(cur = memchr(cur, '\n', top - cur)))
