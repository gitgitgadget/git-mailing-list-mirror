Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFBC71F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 11:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfDWLbQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 Apr 2019 07:31:16 -0400
Received: from smtppost.atos.net ([193.56.114.165]:25220 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 07:31:16 -0400
Received: from mail1-ext.my-it-solutions.net (mail1-ext.my-it-solutions.net) by smarthost4.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 444b_758a_6cf809f4_9a5f_4208_857f_417b3703695f;
        Tue, 23 Apr 2019 13:31:07 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail1-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3NBV6gG003508
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:31:06 +0200
Received: from DEFTHW99ETVMSX.ww931.my-it-solutions.net ([10.86.142.50])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3NBV6kI001201
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 13:31:06 +0200
Received: from DEFTHW99ETRMSX.ww931.my-it-solutions.net (10.86.142.99) by
 DEFTHW99ETVMSX.ww931.my-it-solutions.net (10.86.142.50) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 23 Apr 2019 13:31:05 +0200
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.99) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 23 Apr 2019 13:31:04 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB5254.eurprd02.prod.outlook.com (20.178.90.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 23 Apr 2019 11:31:03 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 11:31:02 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Topic: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Index: AQHU+a/BrB7ZLE29Jku4TzdCEFH6dKZJjFlqgAAO6Kk=
Date:   Tue, 23 Apr 2019 11:31:02 +0000
Message-ID: <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>,<xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7374689d-2453-4757-0f19-08d6c7df2ad5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB5254;
x-ms-traffictypediagnostic: AM6PR02MB5254:
x-microsoft-antispam-prvs: <AM6PR02MB5254895E2CB03A8895F26D3EEA230@AM6PR02MB5254.eurprd02.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(68736007)(186003)(25786009)(86362001)(76176011)(6506007)(26005)(102836004)(97736004)(5660300002)(52536014)(6246003)(71190400001)(55016002)(9686003)(71200400001)(53936002)(7736002)(74316002)(305945005)(476003)(33656002)(53346004)(4326008)(446003)(486006)(11346002)(316002)(3846002)(6116002)(7696005)(99286004)(8676002)(66066001)(81156014)(81166006)(14454004)(8936002)(14444005)(256004)(6916009)(2906002)(66556008)(76116006)(73956011)(64756008)(66946007)(478600001)(66446008)(6436002)(66476007)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5254;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tA75IOm6JETzKpoTPrDzhpuhCVn+qmnPSKTPl9at1TYLbbtg0LI5uvKdKhTtlcKsiTODeBfXyW4+q47uNQHIBLNsCkV9K24JSaPs0YVb1VyMw7KPIpK5rk9+qh34TMJTZp8sjVw+cJCa8pQD+ja95r/niUgVGRaSNj9vJINNOvIxoeW4ErRGZmIYNA3ZTcUTUZqZswxtcSa5lJCfWj1EYQb9E6+H1WVo87AZfgFTxuy1AL7Huv3ya4RdUEnJt4R7TsLHDmcnUKOo2bAZ3i6q2Sqbq3n+FP9i7mAencukQ2SAyUuNOIjDfZPxIn0zX2A/RKJiVlFZ8F134tD4fY3iLXdOh9qqQbAhrIBwA+fe9y+XbGXvHYsdyD3jUf3+U8zJyA4Dj9UpyD7uUmp/+IYEgKZsxhhJbCodx/mMKlbRPwg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7374689d-2453-4757-0f19-08d6c7df2ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:31:02.8653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5254
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitster@pobox.com>
> > On some OSes like AIX, access with X_OK is always true if launched under
> > root.
> 
> That may be the case, but you'd need to describe why it is a problem
> here, before talking about the need for a "work around".
> 
> For example, if a directory on $PATH has a file called git-frotz
> that has no executable bit, perhaps "git frotz" would execute that
> file but only when you are running it as the root user, but not as
> any other user.
> 
> But that by itself does not sound like a problem to me.  After all,
> a user with such a set-up on AIX may deliberately wanted to make
> sure that a program like "git-frotz" that is only useful for
> administrative purposes does not get in the way when using "git"
> normally, but becomes available only when the user does "su".  IOW,
> that sounds more like a feature an AIX user might want to take
> advantage of.
> 
> Perhaps the reason why you do not want to use access(X_OK) that
> returns true for root may be different from the above, but without
> knowing what it is, it is far from clear to me why this patch is a
> good idea.  The patch needs to be justified a lot better.
> 
> Everything below may become a moot point, as it is unclear if the
> (untold) motivation behind this change makes sense in the first
> place, but assuming that it is a good change that merely is poorly
> explained, let's read on.
> 

This patch is needed in order to have hooks working on AIX. When run as root,
access on hooks will return true even if a hook can't be executed. Therefore,
as far as I know, git will try to execute it as is and we'll get this kind of
error:
"git commit -m content
 fatal: cannot exec '.git/hooks/pre-commit': Permission denied"

I'm not fully aware about how git is using access and if it's adding some chmod,
if it returns false. 

We already know that there is some problems with access() as it has already
occurs during our port of bash. Note that a part of this code comes from it.

We find this work around and thought it could be interesting to add it in the
source code as some others OS (like Solaris according to bash) has the same kind
of problems.
However, you're right it's far from perfect and I might have
submitted to soon, sorry about that.. 

> > diff --git a/compat/access.c b/compat/access.c
> > new file mode 100644
> > index 0000000000..e4202d4585
> > --- /dev/null
> > +++ b/compat/access.c
> > @@ -0,0 +1,29 @@
> > +#include "../git-compat-util.h"
> 
> This will get interesting.
> 
> > +/* Do the same thing access(2) does, but use the effective uid and gid,
> > +   and don't make the mistake of telling root that any file is
> > +   executable.  This version uses stat(2). */
> 
>         /*
>          * Our multi-line comment looks more like
>          * this.  A slash-asterisk without anything else
>          * on its own line begins it, and it is concluded
>          * with  an asterisk-slash on its own line.
>          * Each line in between begins with an asterisk,
>          * and the asterisks align on a monospace terminal.
>          */
> 
> > +int git_access (const char *path, int mode)
> 
> No SP after function name before the parens that begins the
> parameter list.
> 
> > +{
> > +     struct stat st;
> > +     uid_t euid = geteuid();
> > +     uid_t uid = getuid();
> > +
> > +     if (stat(path, &st) < 0)
> > +             return -1;
> 
> This stat is a wasted syscall if the running user is not root.
> Structure the function more like
> 
> 
>         int git_access(const char *path, int mode)
>         {
>                 struct stat st;
> 
>                 /* do not interfere a normal user */
>                 if (geteuid())
>                         return access(path, mode);
> 
>                 if (stat(path, &st) < 0)
>                         return -1; /* errno apprpriately set by stat() */
>                 ... other stuff needed for the root user ...
>         }
> 
> Does the true UID matter for the purpose of permission/privilege
> checking?  Why do we have to check anything other than the effective
> UID?
>

Actually, I don't know. Bash is doing it but I think EUID is enough. 

> > +     if (!(uid) || !(euid)) {
> > +             /* Root can read or write any file. */
> > +             if (!(mode & X_OK))
> > +                     return 0;
> > +
> > +             /* Root can execute any file that has any one of the execute
> > +                bits set. */
> > +             if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
> > +                     return 0;
> > +             errno = EACCES;
> > +             return -1;
> > +     }
> > +
> > +     return access(path, X_OK);
> 
> I think the last "fallback to the system access()" is wrong, as the
> "special case for root" block seems to except that the function may
> be called to check for Read or Write permission, not just for X_OK.

That's a mistake from me. It should be "mode" instead of "X_OK". It seems that 
most of the time, it's used only with X_OK or F_OK that's why it has worked. I'll 
fix that. 

> 
> > +}
> > diff --git a/config.mak.uname b/config.mak.uname
> > index 86cbe47627..ce13ab8295 100644
> > --- a/config.mak.uname
> > +++ b/config.mak.uname
> > @@ -270,6 +270,7 @@ ifeq ($(uname_S),AIX)
> >        NEEDS_LIBICONV = YesPlease
> >        BASIC_CFLAGS += -D_LARGE_FILES
> >        FILENO_IS_A_MACRO = UnfortunatelyYes
> > +     NEED_ACCESS_ROOT_HANDLER = UnfortunatelyYes
> >        ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
> >                NO_PTHREADS = YesPlease
> >        else
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 31b47932bd..bb8df9d2e5 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1242,6 +1242,14 @@ int git_fileno(FILE *stream);
> >  # endif
> >  #endif
> 
> As I promised earlier, this will get interesting.
> 
> > +#ifdef NEED_ACCESS_ROOT_HANDLER
> > +#ifdef access
> > +#undef access
> > +#endif
> 
> If a platform that needs git_access() wrapper happens to define
> access(2) as a macro in its system header, you would lose the real
> name of that function with this.
> 
> > +#define access git_access
> > +extern int git_access(const char *path, int mode);
> 
> And in any source file that includes git-compat-util.h, when you
> make a call to access(2), you'll end up calling git_access()
> instead.
> 
> Remember what was in the end (in your original) or the early part of
> git_access() that handled the case where the function is called for
> a non-root user?  Yes, we write "access(path, mode)", expecting to
> make a fallback call to the system-supplied access(2).  With this
> include file, that will never happen---instead, it will recurse in
> itself forever.
> 
> See how FILENO_IS_A_MACRO defined immediately before this part uses
> the "#ifndef COMPAT_CODE" to guard against exactly the same problem.

Alright, I now understand how this work. Actually, I haven't thought about that
problem. But yeah this cannot work at the moment. I'll redo this patch and check
if everything is still working.
I'm sorry about these mistakes. I've made this patch quickly in order to have
something else working. It seems to be too quickly. I'll fix that !  

By the way, do I need to recreate a thread with [PATCH v2] ? Or I'll add the new
version in this one ? I don't know how you're proceeding.  
> 
> 
> Thanks.
