From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] wincred: improve compatibility with windows versions
Date: Fri, 4 Jan 2013 22:57:35 +0100
Message-ID: <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
References: <50E73B80.4070105@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Jeff King <peff@peff.net>
To: blees@dcon.de
X-From: msysgit+bncBDR53PPJ7YHRB6FATWDQKGQEJMXFGTY@googlegroups.com Fri Jan 04 22:58:35 2013
Return-path: <msysgit+bncBDR53PPJ7YHRB6FATWDQKGQEJMXFGTY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f184.google.com ([209.85.213.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB6FATWDQKGQEJMXFGTY@googlegroups.com>)
	id 1TrFHd-0004Ux-5u
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jan 2013 22:58:33 +0100
Received: by mail-ye0-f184.google.com with SMTP id r12sf10144845yen.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jan 2013 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        bh=FDdr6g3AOu34JRJxwlGwKisINVG+xH47UaAtoIaviRg=;
        b=LcRrfNuAGrgfydr5L30jDAH3sJw3+MpzszcjcfpHjsrSEEA2sWwCeJ8wNqA00/hymD
         fLHzwy46PF7QRpHqS37iLV8mTeczp2SRe6zK4hT/TFfUH2PDXhzdSHEnVw0XFPZ7zk9M
         AJ/ViU7yN95ZEErgvUz9D67eb11rlakRq7EOO9wcR6X20rTQnLQIhlsuAZfIco79VWrl
         H9H0AtNx5NDV7ZepVdHULyVNOetwb7gAp43OKE5f7lOs/BWilOfhagnKqpiICw3jdq9k
         A0RN+eE3rcQs2PLou 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        bh=FDdr6g3AOu34JRJxwlGwKisINVG+xH47UaAtoIaviRg=;
        b=GS1sH9BeNtU1n686MhXhCgnu0rfb3JuHn6zYU0M2GL6bXOoNkbYalg9sg0w5UgN63A
         Pga1rRHSdDSUHwLd+6ajlUxrPpcXTolT6z/mWkveg8HMLPMaD7SZ9UgxDS518BOJumzr
         Y0PpM9s5fagg96EbgbKq3htdWiTf6NR5lAX3+CodizE+P34vexzFE9GUsJE6O4QpsiO6
         TvyrpzUa85wKLxr/+gPNh9TL+ud2S4rfOwr/vnBBNP0bRSsN79WHdVxes9FjwFxVraXh
         5WKgxxvV5IKHJU13rBFxGkZ2 
X-Received: by 10.50.33.171 with SMTP id s11mr15872821igi.13.1357336697273;
        Fri, 04 Jan 2013 13:58:17 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.5.175 with SMTP id t15ls173717igt.33.canary; Fri, 04 Jan
 2013 13:58:16 -0800 (PST)
X-Received: by 10.42.247.69 with SMTP id mb5mr42207614icb.4.1357336696625;
        Fri, 04 Jan 2013 13:58:16 -0800 (PST)
X-Received: by 10.42.247.69 with SMTP id mb5mr42207613icb.4.1357336696608;
        Fri, 04 Jan 2013 13:58:16 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com [209.85.223.171])
        by gmr-mx.google.com with ESMTPS id wu4si54674igb.3.2013.01.04.13.58.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jan 2013 13:58:16 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.223.171 as permitted sender) client-ip=209.85.223.171;
Received: by mail-ie0-f171.google.com with SMTP id 17so20482907iea.30
        for <msysgit@googlegroups.com>; Fri, 04 Jan 2013 13:58:16 -0800 (PST)
Received: by 10.50.184.232 with SMTP id ex8mr46683872igc.30.1357336696435;
 Fri, 04 Jan 2013 13:58:16 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Fri, 4 Jan 2013 13:57:35 -0800 (PST)
In-Reply-To: <50E73B80.4070105@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 209.85.223.171 as
 permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212648>

On Fri, Jan 4, 2013 at 9:28 PM, Karsten Blees <karsten.blees@gmail.com> wro=
te:
> On WinXP, the windows credential helper doesn't work at all (due to missi=
ng
> Cred[Un]PackAuthenticationBuffer APIs). On Win7, the credential format us=
ed
> by wincred is incompatible with native Windows tools (such as the control
> panel applet or 'cmdkey.exe /generic'). These Windows tools only set the
> TargetName, UserName and CredentialBlob members of the CREDENTIAL
> structure (where CredentialBlob is the UTF-16-encoded password).
>
> Remove the unnecessary packing / unpacking of the password, along with th=
e
> related API definitions, for compatibility with Windows XP.
>
> Don't use CREDENTIAL_ATTRIBUTEs to identify credentials for compatibility
> with Windows credential manager tools. Parse the protocol, username, host
> and path fields from the credential's target name instead.
>
> While we're at it, optionally accept CRLF (instead of LF only) to simplif=
y
> debugging in bash / cmd.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>
> Hi,
>
> I tried the windows credential helper yesterday and found that it doesn't=
 work on XP at all, and doesn't work properly in combination with Win7 cred=
ential manager tools. So here's a patch that reduces it to the functionalit=
y provided / expected by Windows.
>
> @Erik, Jeff: Please let me know if I'm missing something and the use of C=
red[Un]PackAuthenticationBuffer or CREDENTIAL_ATTRIBUTEs actually served a =
useful purpose.
>

The only reason why I used Cred[Un]PackAuthenticationBuffer, were that
I wasn't aware that it was possible any other way. I didn't even know
there was a Windows Credential Manager in Windows XP.

The credential attributes were because they were convenient, and I'm
not sure I understand what you mean about the Win7 credential manager
tools. I did test my code with it - in fact, it was a very useful tool
for debugging the helper.

Are you referring to the credentials not *looking* like normal
HTTP-credentials? If so, I simply didn't see that as a goal. Why would
it be? Compatibility with IE? We already lose that with our "git:"
prefix in the target, no? Perhaps we can lose the "git:"-prefix, and
gain IE-compatibility when the protocol matches?

But, if we do any of these changes, does this mean I will lose my
existing credentials? It's probably not a big deal, but it's worth a
mention, isn't it?

> @@ -67,20 +61,14 @@ typedef struct _CREDENTIALW {
>  #define CRED_MAX_ATTRIBUTES 64
>
>  typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
> -typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, DW=
ORD,
> -    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
>  typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
>      PCREDENTIALW **);
> -typedef BOOL (WINAPI *CredPackAuthenticationBufferWT)(DWORD, LPWSTR, LPW=
STR,
> -    PBYTE, DWORD *);
>  typedef VOID (WINAPI *CredFreeT)(PVOID);
>  typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
>
>  static HMODULE advapi, credui;

Perhaps get rid of credui also?

>  static CredWriteWT CredWriteW;
> -static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW;
>  static CredEnumerateWT CredEnumerateW;
> -static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
>  static CredFreeT CredFree;
>  static CredDeleteWT CredDeleteW;
>
> @@ -88,74 +76,64 @@ static void load_cred_funcs(void)
>  {
>         /* load DLLs */
>         advapi =3D LoadLibrary("advapi32.dll");
> -       credui =3D LoadLibrary("credui.dll");
> -       if (!advapi || !credui)
> +       if (!advapi)
>                 die("failed to load DLLs");

It's not multiple DLLs any more, so perhaps "failed to load
advapi32.dll" instead?

> -static char target_buf[1024];
> -static char *protocol, *host, *path, *username;
> -static WCHAR *wusername, *password, *target;
> +static WCHAR *wusername, *password, *protocol, *host, *path, target[1024=
];
>
> -static void write_item(const char *what, WCHAR *wbuf)
> +static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>  {
>         char *buf;
> -       int len =3D WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, NU=
LL,
> +       int len =3D WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, NULL, 0, =
NULL,
>             FALSE);
>         buf =3D xmalloc(len);
>
> -       if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, FA=
LSE))
> +       if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, buf, len, NULL, =
FALSE))
>                 die("WideCharToMultiByte failed!");
>
>         printf("%s=3D", what);
> -       fwrite(buf, 1, len - 1, stdout);
> +       fwrite(buf, 1, len, stdout);
>         putchar('\n');
>         free(buf);
>  }
>

When the password-blob is simply UTF-16 encoded, are the
zero-termination not included? That's the reason for this change,
right?

> -static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
> -    const char *want)
> +static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>  {
> -       int i;
> -       if (!want)
> -               return 1;
> -
> -       for (i =3D 0; i < cred->AttributeCount; ++i)
> -               if (!wcscmp(cred->Attributes[i].Keyword, keyword))
> -                       return !strcmp((const char *)cred->Attributes[i].=
Value,
> -                           want);
> -
> -       return 0; /* not found */
> +       LPCWSTR start =3D *ptarget;
> +       LPCWSTR end =3D *delim ? wcsstr(start, delim) : start + wcslen(st=
art);
> +       int len =3D end ? end - start : wcslen(start);
> +       /* update ptarget if we either found a delimiter or need a match =
*/
> +       if (end || want)
> +               *ptarget =3D end ? end + wcslen(delim) : start + len;
> +       return !want || (!wcsncmp(want, start, len) && !want[len]);
>  }
>

I'm a bit tired now, but I'm having a hard time reading this code.
Right now it seems it's a bit too ternary-expression heavy for my
taste, though.

>  static int match_cred(const CREDENTIALW *cred)
>  {
> -       return (!wusername || !wcscmp(wusername, cred->UserName)) &&
> -           match_attr(cred, L"git_protocol", protocol) &&
> -           match_attr(cred, L"git_host", host) &&
> -           match_attr(cred, L"git_path", path);
> +       LPCWSTR target =3D cred->TargetName;
> +       if (wusername && wcscmp(wusername, cred->UserName))
> +               return 0;
> +
> +       return match_part(&target, L"git", L":") &&
> +               match_part(&target, protocol, L"://") &&
> +               match_part(&target, wusername, L"@") &&
> +               match_part(&target, host, L"/") &&
> +               match_part(&target, path, L"");
>  }
>

Ugh, it feels a bit wrong to store and verify the username twice. Do
we really have to?

The target needs to be unique, even if two different usernames are
stored for the same site under the same conditions. So probably. It
just doesn't feel quite right.

> @@ -165,44 +143,15 @@ static void get_credential(void)
>         /* search for the first credential that matches username */
>         for (i =3D 0; i < num_creds; ++i)
>                 if (match_cred(creds[i])) {
> -                       cred =3D creds[i];
> +                       write_item("username", creds[i]->UserName,
> +                               wcslen(creds[i]->UserName));
> +                       write_item("password",
> +                               (LPCWSTR)creds[i]->CredentialBlob,
> +                               creds[i]->CredentialBlobSize / sizeof(WCH=
AR));
>                         break;
>                 }
> -       if (!cred)
> -               return;
> -
> -       CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
> -           cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
> -           NULL, &pass_buf_size);
> -
> -       user_buf =3D xmalloc(user_buf_size * sizeof(WCHAR));
> -       pass_buf =3D xmalloc(pass_buf_size * sizeof(WCHAR));
> -
> -       if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
> -           cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NUL=
L,
> -           pass_buf, &pass_buf_size))
> -               die("CredUnPackAuthenticationBuffer failed");
>
>         CredFree(creds);
> -
> -       /* zero-terminate (sizes include zero-termination) */
> -       user_buf[user_buf_size - 1] =3D L'\0';
> -       pass_buf[pass_buf_size - 1] =3D L'\0';
> -
> -       write_item("username", user_buf);
> -       write_item("password", pass_buf);
> -
> -       free(user_buf);
> -       free(pass_buf);
> -}

Nice!

> -
> -static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keyword=
,
> -    const char *value)
> -{
> -       attr->Keyword =3D (LPWSTR)keyword;
> -       attr->Flags =3D 0;
> -       attr->ValueSize =3D strlen(value) + 1; /* store zero-termination =
*/
> -       attr->Value =3D (LPBYTE)value;
>  }
>
>  static void store_credential(void)
> @@ -215,40 +164,18 @@ static void store_credential(void)
>         if (!wusername || !password)
>                 return;
>
> -       /* query buffer size */
> -       CredPackAuthenticationBufferW(0, wusername, password,
> -           NULL, &auth_buf_size);
> -
> -       auth_buf =3D xmalloc(auth_buf_size);
> -
> -       if (!CredPackAuthenticationBufferW(0, wusername, password,
> -           auth_buf, &auth_buf_size))
> -               die("CredPackAuthenticationBuffer failed");
> -
>         cred.Flags =3D 0;
>         cred.Type =3D CRED_TYPE_GENERIC;
>         cred.TargetName =3D target;
>         cred.Comment =3D L"saved by git-credential-wincred";
> -       cred.CredentialBlobSize =3D auth_buf_size;
> -       cred.CredentialBlob =3D auth_buf;
> +       cred.CredentialBlobSize =3D (wcslen(password)) * sizeof(WCHAR);
> +       cred.CredentialBlob =3D (LPVOID)password;
>         cred.Persist =3D CRED_PERSIST_LOCAL_MACHINE;
> -       cred.AttributeCount =3D 1;
> -       cred.Attributes =3D attrs;
> +       cred.AttributeCount =3D 0;
> +       cred.Attributes =3D NULL;
>         cred.TargetAlias =3D NULL;
>         cred.UserName =3D wusername;
>
> -       write_attr(attrs, L"git_protocol", protocol);
> -
> -       if (host) {
> -               write_attr(attrs + cred.AttributeCount, L"git_host", host=
);
> -               cred.AttributeCount++;
> -       }
> -
> -       if (path) {
> -               write_attr(attrs + cred.AttributeCount, L"git_path", path=
);
> -               cred.AttributeCount++;
> -       }
> -
>         if (!CredWriteW(&cred, 0))
>                 die("CredWrite failed");
>  }

Nice.

> @@ -284,10 +211,13 @@ static void read_credential(void)
>
>         while (fgets(buf, sizeof(buf), stdin)) {
>                 char *v;
> +               int len =3D strlen(buf);
> +               /* strip trailing CR / LF */
> +               while (len && strchr("\r\n", buf[len - 1]))
> +                       buf[--len] =3D 0;
>
> -               if (!strcmp(buf, "\n"))
> +               if (!*buf)
>                         break;
> -               buf[strlen(buf)-1] =3D '\0';
>
>                 v =3D strchr(buf, '=3D');
>                 if (!v)

I think this part deserves a separate patch, no?

> @@ -295,13 +225,12 @@ static void read_credential(void)
>                 *v++ =3D '\0';
>
>                 if (!strcmp(buf, "protocol"))
> -                       protocol =3D xstrdup(v);
> +                       protocol =3D utf8_to_utf16_dup(v);
>                 else if (!strcmp(buf, "host"))
> -                       host =3D xstrdup(v);
> +                       host =3D utf8_to_utf16_dup(v);
>                 else if (!strcmp(buf, "path"))
> -                       path =3D xstrdup(v);
> +                       path =3D utf8_to_utf16_dup(v);
>                 else if (!strcmp(buf, "username")) {
> -                       username =3D xstrdup(v);
>                         wusername =3D utf8_to_utf16_dup(v);
>                 } else if (!strcmp(buf, "password"))
>                         password =3D utf8_to_utf16_dup(v);

So, you need the strings as UTF-16 instead so you can match against them...

> @@ -330,22 +259,20 @@ int main(int argc, char *argv[])
>                 return 0;
>
>         /* prepare 'target', the unique key for the credential */
> -       strncat(target_buf, "git:", sizeof(target_buf));
> -       strncat(target_buf, protocol, sizeof(target_buf));
> -       strncat(target_buf, "://", sizeof(target_buf));
> -       if (username) {
> -               strncat(target_buf, username, sizeof(target_buf));
> -               strncat(target_buf, "@", sizeof(target_buf));
> +       wcscpy(target, L"git:");
> +       wcsncat(target, protocol, ARRAY_SIZE(target));
> +       wcsncat(target, L"://", ARRAY_SIZE(target));
> +       if (wusername) {
> +               wcsncat(target, wusername, ARRAY_SIZE(target));
> +               wcsncat(target, L"@", ARRAY_SIZE(target));
>         }
>         if (host)
> -               strncat(target_buf, host, sizeof(target_buf));
> +               wcsncat(target, host, ARRAY_SIZE(target));
>         if (path) {
> -               strncat(target_buf, "/", sizeof(target_buf));
> -               strncat(target_buf, path, sizeof(target_buf));
> +               wcsncat(target, L"/", ARRAY_SIZE(target));
> +               wcsncat(target, path, ARRAY_SIZE(target));
>         }
>
> -       target =3D utf8_to_utf16_dup(target_buf);
> -

...Which means that you are composing a UTF-16 target directly rather
than ASCII. Looks sane.

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
