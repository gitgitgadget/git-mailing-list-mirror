From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-compat-util.h: reduce optimization level to
 1 on MinGW env.
Date: Wed, 25 Sep 2013 12:15:27 -0700
Message-ID: <20130925191527.GY9464@google.com>
References: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Wataru Noguchi <wnoguchi.0727@gmail.com>
X-From: msysgit+bncBD6LRKOE4AIRBVPMRSJAKGQEQVSDEZQ@googlegroups.com Wed Sep 25 21:15:36 2013
Return-path: <msysgit+bncBD6LRKOE4AIRBVPMRSJAKGQEQVSDEZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBVPMRSJAKGQEQVSDEZQ@googlegroups.com>)
	id 1VOuYh-0001M4-8q
	for gcvm-msysgit@m.gmane.org; Wed, 25 Sep 2013 21:15:35 +0200
Received: by mail-qc0-f184.google.com with SMTP id e20sf21437qcy.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Sep 2013 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=W7eGDRWfVIjvt9QX2COy1gR/YddeQxckcAZnPT8E9Lg=;
        b=NsshLooWIVp+HOXabCKinJtlaLFAiJ5+x+B46QBiNVeTSsn+Hp+34Y2owE2/z7K7y7
         ASHsMrTAiasVAwTlvf+ZNceeH/DM0iochHmpAgMYq2D7kiI9T46xE5dWos3Ye8sL6Ozx
         aWaSXA8tLm0J7zxXf+GLLqPw+jn1avbJE2eV/HGS32yh7mkOZtR8hwcBgSp6lkKZnSA/
         EnkJ6bx3H3agv7tsp6a7vkTYTc3Au6OB7b6kyfVVhrydqBVgAqiy7205FWLJijnNOTsl
         HhlRMzGRcstH//91252uGoxDdAKqGBnohXuhL9qNMl6eKFBsRxtCXBDzvEIA8gzQ5iXc
   
X-Received: by 10.182.246.133 with SMTP id xw5mr427206obc.14.1380136534421;
        Wed, 25 Sep 2013 12:15:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.142.36 with SMTP id rt4ls1254423obb.69.gmail; Wed, 25 Sep
 2013 12:15:33 -0700 (PDT)
X-Received: by 10.66.220.163 with SMTP id px3mr885105pac.38.1380136533537;
        Wed, 25 Sep 2013 12:15:33 -0700 (PDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com [2607:f8b0:400e:c03::232])
        by gmr-mx.google.com with ESMTPS id dk16si6288743pac.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 12:15:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::232 as permitted sender) client-ip=2607:f8b0:400e:c03::232;
Received: by mail-pa0-f50.google.com with SMTP id fb1so249179pad.37
        for <msysgit@googlegroups.com>; Wed, 25 Sep 2013 12:15:33 -0700 (PDT)
X-Received: by 10.66.102.40 with SMTP id fl8mr754337pab.167.1380136531951;
        Wed, 25 Sep 2013 12:15:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oj6sm55348066pab.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 12:15:30 -0700 (PDT)
In-Reply-To: <1380123941-25941-1-git-send-email-wnoguchi.0727@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:400e:c03::232
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235367>

(cc-ing the Git for Windows maintainers)
Hi,

Wataru Noguchi wrote:

> Git for Windows crashes when clone Japanese multibyte repository.
> - Japanese Base Encoding is Shift-JIS.
> - It happens Japanese multibyte directory name and too-long directory pat=
h
> - Linux(ex. Ubuntu 13.04 amd64) can clone normally.
> - example repository is here:
>
> git clone https://github.com/wnoguchi/mingw-checkout-crash.git
>
> - The reproduce crash repository contains following file only.
>   - following directory and file name is encoded for this commit log.
>   - actually file name is decoded.]
>   %E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%8=
8%E3%83%AA%201-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%=
E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%202-long-long-long-dirname/%E6=
%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83=
%AA%203-long-long-long-dirname/%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A=
3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%204-long-long-long-dirname/%E6%97%A5%=
E6%9C%AC%E8%AA%9E%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%205=
-long-long-long-dirname/%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB%E3%81%8A%E8%AA=
%AD%E3%81%BF%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84.txt
> - only one commit.
>
> This commit reduce gcc optimization level from O2 to O1 when MinGW Window=
s environment.
>
> Signed-off-by: Wataru Noguchi <wnoguchi.0727@gmail.com>

Thanks.

> ---
>  git-compat-util.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a31127f..394c23b 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -90,6 +90,8 @@
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>  #include <winsock2.h>
>  #include <windows.h>
> +/* reduce gcc optimization level to 1 */
> +#pragma GCC optimize ("O1")
>  #define GIT_WINDOWS_NATIVE
>  #endif

Do you know why reducing the optimization level avoids a crash?
Perhaps this is just masking the symptoms and the problem is still
lurking.

If changing the optimization level turns out to be the right fix, I
would prefer to see this change made in the Makefile instead of
git-compat-util.h.  That way, the user building can still easily
override the optimization settings to -O0 if they want to during a
debugging session.

What do you think?

Hope that helps,
Jonathan

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
