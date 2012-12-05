From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Wed, 5 Dec 2012 17:23:57 +0100
Message-ID: <CABPQNSbsp_V7o8jQrwjSE_x3z3cAf7T3evK+Xq9kVZF0HrGwpg@mail.gmail.com>
References: <1354617713-7436-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info>
 <CABPQNSbcSEKApDBWWt7z67DvV6=JwTGebdk6hjgR1OppPyOQwg@mail.gmail.com> <alpine.DEB.1.00.1212051657131.31987@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBRPK7WCQKGQEKGGWOPI@googlegroups.com Wed Dec 05 17:24:52 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBRPK7WCQKGQEKGGWOPI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f55.google.com ([209.85.212.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBRPK7WCQKGQEKGGWOPI@googlegroups.com>)
	id 1TgHmF-0002PB-8J
	for gcvm-msysgit@m.gmane.org; Wed, 05 Dec 2012 17:24:51 +0100
Received: by mail-vb0-f55.google.com with SMTP id v13sf3128524vbk.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Dec 2012 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=nuyzeBSkM3Mg6oxgDTgJAJTXU40u1gwo06tF3Bd95Oc=;
        b=JFWttGRErkmUHFccwjO6vWrtom0PI3o3mEQDprMbF24wyn4NoR6BpimFJZH8sOJsXU
         qxYNGF+Xt+NlSbBDUvufYe3H7hlNwsBtJ9y9fbXhAmsVwYmGWpur8d9XpdEF0YgaxlS+
         JSYQIHXUPPm3talI+ZH06Fk42T0s2xnX69UHt1Ztc8Jov1KzwLes2674dLvPZNIYO5JF
         bsq3IHw6XuidMMaeKabfXCTcDlD/ds74uAvMUGWr9rbuo99mHU1+OJwdJ684kIn9YTo3
         A30zW8Vnl9d/MlLfIsUkinrBxfXL6GxCdqmtNpSYGSLur1Y/NGP9WyHpmFVZ2wiqfe0N
         KCcg==
Received: by 10.49.18.231 with SMTP id z7mr3908594qed.25.1354724678827;
        Wed, 05 Dec 2012 08:24:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.26.70 with SMTP id j6ls1039850qeg.86.gmail; Wed, 05 Dec
 2012 08:24:37 -0800 (PST)
Received: by 10.58.189.35 with SMTP id gf3mr5933465vec.11.1354724677373;
        Wed, 05 Dec 2012 08:24:37 -0800 (PST)
Received: by 10.58.189.35 with SMTP id gf3mr5933464vec.11.1354724677361;
        Wed, 05 Dec 2012 08:24:37 -0800 (PST)
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com [209.85.220.175])
        by gmr-mx.google.com with ESMTPS id es5si1481755vdb.2.2012.12.05.08.24.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2012 08:24:37 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.220.175 as permitted sender) client-ip=209.85.220.175;
Received: by mail-vc0-f175.google.com with SMTP id fy7so4853881vcb.34
        for <msysgit@googlegroups.com>; Wed, 05 Dec 2012 08:24:37 -0800 (PST)
Received: by 10.52.97.104 with SMTP id dz8mr7589602vdb.21.1354724677262; Wed,
 05 Dec 2012 08:24:37 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Wed, 5 Dec 2012 08:23:57 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1212051657131.31987@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.220.175 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211130>

On Wed, Dec 5, 2012 at 5:02 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi kusma,
>
> On Wed, 5 Dec 2012, Erik Faye-Lund wrote:
>
>> Sorry for a late reply.
>
> Yeah, sorry, my replies tend to be delayed a lot. For the record: your
> reply was not at all late.
>
>> On Tue, Dec 4, 2012 at 5:35 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Tue, 4 Dec 2012, Erik Faye-Lund wrote:
>> >
>> >> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"), a
>> >> check was added to prevent us from retrying to delete a directory
>> >> that is both in use and non-empty.
>> >>
>> >> However, this logic was slightly flawed; since we didn't return
>> >> immediately, we end up falling out of the retry-loop, but right into
>> >> the prompting loop.
>> >>
>> >> Fix this by simply returning from the function instead of breaking
>> >> the loop.
>> >>
>> >> While we're at it, change the second break to a return as well; we
>> >> already know that we won't enter the prompting-loop, beacuse
>> >> is_file_in_use_error(GetLastError()) already evaluated to false.
>> >
>> > I usually prefer to break from the loop, to be able to add whatever
>> > cleanup code we might need in the future after the loop.
>> >
>> > So does this fix the problem for you?
>> >
>> > -- snipsnap --
>> > diff --git a/compat/mingw.c b/compat/mingw.c
>> > index 04af3dc..504495a 100644
>> > --- a/compat/mingw.c
>> > +++ b/compat/mingw.c
>> > @@ -259,7 +259,8 @@ int mingw_rmdir(const char *pathname)
>> >                 return -1;
>> >
>> >         while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
>> > -               if (!is_file_in_use_error(GetLastError()))
>> > +               errno = err_win_to_posix(GetLastError());
>> > +               if (errno != EACCESS)
>> >                         break;
>> >                 if (!is_dir_empty(wpathname)) {
>> >                         errno = ENOTEMPTY;
>> > @@ -275,7 +276,7 @@ int mingw_rmdir(const char *pathname)
>> >                 Sleep(delay[tries]);
>> >                 tries++;
>> >         }
>> > -       while (ret == -1 && is_file_in_use_error(GetLastError()) &&
>> > +       while (ret == -1 && errno == EACCESS &&
>> >                ask_yes_no_if_possible("Deletion of directory '%s' failed. "
>> >                         "Should I try again?", pathname))
>> >                ret = _wrmdir(wpathname);
>>
>> Yes, as long as you do s/EACCESS/EACCES/ first. I don't mind such a
>> version instead.
>
> As you probably suspected, I did not have a way to test-compile it before
> sending.
>
> The reason I was suggesting my version of the patch was to unify the error
> handling: rather than relying on both errno and GetLastError() (but for
> different error conditions), I would like to rely on only one: errno. That
> way, they cannot contradict each other (as they did in your case).
>

Since we're justifying the approaches, I'd like to explain why I
preferred the return approach: it performs less tests. While this
might sound like premature optimizations, performance is not why I
think it's a good idea. It makes the fix easier to verify; you don't
need to validate that the conditions of the second loop won't happen,
because the code exits quickly.

If we added something that required cleanup, we could change the
return to a goto with a cleanup-label, and it would still be
relatively easy to see what's going on.

> However, I have no strong opinion on this, so please apply the version you
> like better.

Since the issue is present in mainline Git as well, I'd prefer if
Junio merged whatever he prefers. I can produce a proper patch out of
your suggesting, if needed.

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
