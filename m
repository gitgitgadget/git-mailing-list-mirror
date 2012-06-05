From: David Michael Barr <davidbarr@google.com>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Tue, 5 Jun 2012 11:33:16 +1000
Message-ID: <CAFfmPPMLWdVBGBzdXV4QD7tbmgykWmB3OpQmWQ0BAbQiGt7fQg@mail.gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 03:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbieb-0000sB-0P
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 03:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627Ab2FEBdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 21:33:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52158 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2FEBdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 21:33:17 -0400
Received: by obbtb18 with SMTP id tb18so8008635obb.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=iQMVT81H7f8P8AbBk0TeKvSN0itFdtYsJd2YOTki0C8=;
        b=SkHjI2h6R3xia7Qq0fYNiPmb72tgpw7s0JAQ2hxpjCml1E/qga/lwNzqTHXqvviFbG
         fnWkvRoxryZLmv9kYtg+8TFD/tn+4eBP6y4JQ95c/h3w5pZ4Cr7JpCSBIqE8gPnDRaz3
         30IhXaKEkfC4KdD4jWa0C+FIoEj300C7A7pkpftHwk6A1W5X9xG/EB+MJd1uxkjolRAO
         TrU0NF992mwAxACEg+EhlFAM6hgqVg8URbh1qQzCYZSitkgIO/umHZ00cPWYL8xdF0D8
         EOWFy+lxagGatfsL6xMP1veeQJDrRPUu6GkZTO3vxTdira2m/t0luIyarsuhlKtt1cva
         Leqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=iQMVT81H7f8P8AbBk0TeKvSN0itFdtYsJd2YOTki0C8=;
        b=ODpEcZMCUnMhDoJ6oslvR8I7Sz5JpfUXmQPoHDFsT26ejA2tUr0c/8Lf3YVnrLi3RW
         eUYTeDo74RZxYhoAdjHQodF+c3duaS9fOIUV3e0en8NMrML81UgoDeETH+BMhoBHwZBl
         eAEFU6KytWJAbuSXf0mKo7kgPNCndryfh6Wo/Wp5dbsAijxYaqIVb1LmeLUvcJO1ZbJu
         7RO1quzbyjcP5GZ88mZ07bV4IS/RgM3Cdb2QGSt3hyKFbEIxKvP+bNmfOhxa+lOljnN5
         2CtanhEEltIhZRWJcV6yquC2p4BEapzmjc3RFDIDgfx2hg3bfAH0Ww2E57IqELJOqW1/
         rYLw==
Received: by 10.182.207.6 with SMTP id ls6mr11654258obc.12.1338859996536;
        Mon, 04 Jun 2012 18:33:16 -0700 (PDT)
Received: by 10.182.207.6 with SMTP id ls6mr11654249obc.12.1338859996402; Mon,
 04 Jun 2012 18:33:16 -0700 (PDT)
Received: by 10.60.57.39 with HTTP; Mon, 4 Jun 2012 18:33:16 -0700 (PDT)
In-Reply-To: <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlhxpZlGtH8rnuNXFkcUngWrTwj+yk60qD6KXQmNnpyEfSHtnB2EW/RHMrqkPqUj92sSJHLfVKCPRVmDNlZCEilV8Iq8QFUa4qz04phFiczqproWiDi4J1+yAdbSQL2V8FzNDeVmeHZNvmx0oB9Bt0z+Pj/xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199199>

On Tue, Jun 5, 2012 at 3:20 AM, Florian Achleitner
<florian.achleitner.2.6.31@gmail.com> wrote:
> On invocation of a helper a new pipe is opened.
> To close the other end after fork, the prexec_cb feature
> of the run_command api is used.
> If the helper is not used with fast-import later the pipe
> is unused.
> The FD is passed to the remote-helper via it's environment,
> helpers that don't use fast-import can simply ignore it.
> fast-import has an argv for that.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.co=
m>
> ---
> =A0transport-helper.c | =A0 48 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> =A0vcs-svn/svndump.c =A0| =A0 =A09 ++++++++-
> =A02 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 61c928f..b438040 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -17,6 +17,7 @@ struct helper_data {
> =A0 =A0 =A0 =A0const char *name;
> =A0 =A0 =A0 =A0struct child_process *helper;
> =A0 =A0 =A0 =A0FILE *out;
> + =A0 =A0 =A0 int fast_import_backchannel_pipe[2];
> =A0 =A0 =A0 =A0unsigned fetch : 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0import : 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0export : 1,
> @@ -98,19 +99,30 @@ static void do_take_over(struct transport *transp=
ort)
> =A0 =A0 =A0 =A0free(data);
> =A0}
>
> +static int fd_to_close;
> +void close_fd_prexec_cb(void)
> +{
> + =A0 =A0 =A0 if(debug)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "close_fd_prexec_cb clo=
sing %d\n", fd_to_close);
> + =A0 =A0 =A0 close(fd_to_close);
> +}
> +
> =A0static struct child_process *get_helper(struct transport *transpor=
t)
> =A0{
> =A0 =A0 =A0 =A0struct helper_data *data =3D transport->data;
> =A0 =A0 =A0 =A0struct strbuf buf =3D STRBUF_INIT;
> + =A0 =A0 =A0 struct strbuf envbuf =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0struct child_process *helper;
> =A0 =A0 =A0 =A0const char **refspecs =3D NULL;
> =A0 =A0 =A0 =A0int refspec_nr =3D 0;
> =A0 =A0 =A0 =A0int refspec_alloc =3D 0;
> =A0 =A0 =A0 =A0int duped;
> =A0 =A0 =A0 =A0int code;
> + =A0 =A0 =A0 int err;
> =A0 =A0 =A0 =A0char git_dir_buf[sizeof(GIT_DIR_ENVIRONMENT) + PATH_MA=
X + 1];
> =A0 =A0 =A0 =A0const char *helper_env[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git_dir_buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, =A0 /* placeholder */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
> =A0 =A0 =A0 =A0};
>
> @@ -133,6 +145,24 @@ static struct child_process *get_helper(struct t=
ransport *transport)
> =A0 =A0 =A0 =A0snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=3D%s", =
GIT_DIR_ENVIRONMENT, get_git_dir());
> =A0 =A0 =A0 =A0helper->env =3D helper_env;
>
> +
> + =A0 =A0 =A0 /* create an additional pipe from fast-import to the he=
lper */
> + =A0 =A0 =A0 err =3D pipe(data->fast_import_backchannel_pipe);
> + =A0 =A0 =A0 if(err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("cannot create fast_import_backchan=
nel_pipe: %s", strerror(errno));
> +
> + =A0 =A0 =A0 if(debug)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Remote helper created =
fast_import_backchannel_pipe { %d, %d }\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->f=
ast_import_backchannel_pipe[0], data->fast_import_backchannel_pipe[1]);
> +
> + =A0 =A0 =A0 strbuf_addf(&envbuf, "GIT_REPORT_FILENO=3D%d", data->fa=
st_import_backchannel_pipe[0]);
> + =A0 =A0 =A0 helper_env[1] =3D strbuf_detach(&envbuf, NULL);
> +
> + =A0 =A0 =A0 /* after the fork, we need to close the write end in th=
e helper */
> + =A0 =A0 =A0 fd_to_close =3D data->fast_import_backchannel_pipe[1];
> + =A0 =A0 =A0 /* the prexec callback is run just before exec */
> + =A0 =A0 =A0 helper->preexec_cb =3D close_fd_prexec_cb;
> +
> =A0 =A0 =A0 =A0code =3D start_command(helper);
> =A0 =A0 =A0 =A0if (code < 0 && errno =3D=3D ENOENT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Unable to find remote helper for =
'%s'", data->name);
> @@ -141,6 +171,7 @@ static struct child_process *get_helper(struct tr=
ansport *transport)
>
> =A0 =A0 =A0 =A0data->helper =3D helper;
> =A0 =A0 =A0 =A0data->no_disconnect_req =3D 0;
> + =A0 =A0 =A0 free((void*)helper_env[1]);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Open the output as FILE* so strbuf_getline() can be=
 used.
> @@ -237,6 +268,10 @@ static int disconnect_helper(struct transport *t=
ransport)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xwrite(data->helper->i=
n, "\n", 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigchain_pop(SIGPIPE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* close the pipe, it is still open if =
it wasn't used for fast-import. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(data->fast_import_backchannel_pip=
e[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(data->fast_import_backchannel_pip=
e[1]);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(data->helper->in);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(data->helper->out);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fclose(data->out);
> @@ -376,13 +411,20 @@ static int fetch_with_fetch(struct transport *t=
ransport,
> =A0static int get_importer(struct transport *transport, struct child_=
process *fastimport)
> =A0{
> =A0 =A0 =A0 =A0struct child_process *helper =3D get_helper(transport)=
;
> + =A0 =A0 =A0 struct helper_data *data =3D transport->data;
> + =A0 =A0 =A0 struct strbuf buf =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0memset(fastimport, 0, sizeof(*fastimport));
> =A0 =A0 =A0 =A0fastimport->in =3D helper->out;
> =A0 =A0 =A0 =A0fastimport->argv =3D xcalloc(5, sizeof(*fastimport->ar=
gv));
> =A0 =A0 =A0 =A0fastimport->argv[0] =3D "fast-import";
> =A0 =A0 =A0 =A0fastimport->argv[1] =3D "--quiet";
> + =A0 =A0 =A0 strbuf_addf(&buf, "--cat-blob-fd=3D%d", data->fast_impo=
rt_backchannel_pipe[1]);
> + =A0 =A0 =A0 fastimport->argv[2] =3D strbuf_detach(&buf, NULL);
>
> =A0 =A0 =A0 =A0fastimport->git_cmd =3D 1;
> +
> + =A0 =A0 =A0 fd_to_close =3D data->fast_import_backchannel_pipe[0];
> + =A0 =A0 =A0 fastimport->preexec_cb =3D close_fd_prexec_cb;
> =A0 =A0 =A0 =A0return start_command(fastimport);
> =A0}
>
> @@ -427,6 +469,11 @@ static int fetch_with_import(struct transport *t=
ransport,
> =A0 =A0 =A0 =A0if (get_importer(transport, &fastimport))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Couldn't run fast-import");
>
> +
> + =A0 =A0 =A0 /* in the parent process we close both pipe ends. */
> + =A0 =A0 =A0 close(data->fast_import_backchannel_pipe[0]);
> + =A0 =A0 =A0 close(data->fast_import_backchannel_pipe[1]);
> +
> =A0 =A0 =A0 =A0for (i =3D 0; i < nr_heads; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0posn =3D to_fetch[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (posn->status & REF_STATUS_UPTODATE=
)
> @@ -441,6 +488,7 @@ static int fetch_with_import(struct transport *tr=
ansport,
>
> =A0 =A0 =A0 =A0if (finish_command(&fastimport))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("Error while running fast-import")=
;
> + =A0 =A0 =A0 free((void*)fastimport.argv[2]);
> =A0 =A0 =A0 =A0free(fastimport.argv);
> =A0 =A0 =A0 =A0fastimport.argv =3D NULL;
>
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 2f0089f..b1fe03f 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -467,7 +467,14 @@ void svndump_read(const char *url)
>
> =A0static void init()
> =A0{
> - =A0 =A0 =A0 fast_export_init(REPORT_FILENO);
> + =A0 =A0 =A0 int report_fd;
> + =A0 =A0 =A0 char* back_fd_env =3D getenv("GIT_REPORT_FILENO");
> + =A0 =A0 =A0 if(!back_fd_env || sscanf(back_fd_env, "%d", &report_fd=
) !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("Cannot get cat-blob fd from en=
vironment, using default!");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_fd =3D REPORT_FILENO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 fast_export_init(report_fd);
> =A0 =A0 =A0 =A0strbuf_init(&dump_ctx.uuid, 4096);
> =A0 =A0 =A0 =A0strbuf_init(&dump_ctx.url, 4096);
> =A0 =A0 =A0 =A0strbuf_init(&rev_ctx.log, 4096);
> --
> 1.7.9.5

+cc Sverre Rabbelier and Jeff King, as they have been active in
transport-helper.c.

--
David Barr
