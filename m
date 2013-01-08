From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] wincred: improve compatibility with windows versions
Date: Tue, 08 Jan 2013 17:20:10 +0100
Message-ID: <50EC473A.6060203@gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCH3XYXLXQDBBQMOWGDQKGQEDD3JUNQ@googlegroups.com Tue Jan 08 17:20:37 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBQMOWGDQKGQEDD3JUNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBQMOWGDQKGQEDD3JUNQ@googlegroups.com>)
	id 1Tsbuj-0004Er-Sf
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2013 17:20:33 +0100
Received: by mail-we0-f185.google.com with SMTP id r1sf317112wey.12
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2013 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=MyIrblwyP2lXsbzSEt2xhF/KyFgBSguG9KghWTTeUFg=;
        b=sIWg+Zb6mIyKtRda8YgwYu0+NHftFGa4gsmgmepld1jPTIpMTzhWLDPFtTXBKPRgro
         0xsQzfDl7oAk53fI+4pB+U+9NId7DcEY15xj4B0Dy/ZWfckDjH/Fwi+sz0ETc1qKZZbp
         WKP/tCRdcf6n+M0dI3xKxpLp08XOYp8kveCTTXOTj7a3/6aJP9z6bj4f9ZB1AK4pBC5j
         GLVvmPkoJGipyW9ClTU4VJLKnZQHTHsbFUPzuZvgpwHZNT5ZpOl2B3d3yP5jqjF 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=MyIrblwyP2lXsbzSEt2xhF/KyFgBSguG9KghWTTeUFg=;
        b=X9Lejo9hCEI2tx8uym/DMwO+kram733kJWXaAu4s7cLMb6AOf/MfqyZsB2HVwKVDzX
         Uz69IdIUnOBZ0n3AbrLX3OhBncxaSEkCBpX23fNDNoeTga/v5YI9DMIk7AtNBXLGIyuP
         +BlKdEinaZwz6eRJhJBYgBkE2FtLguXAxDehd49obwyGmhDEzr5OAmWanKbaNk6D49t3
         1DJA8ltb6BH5uZsQcCR2HkEq46w1j7VmVogdNfW8pRdd1Lub76iH8HwHauMoqKmQAJnD
  
X-Received: by 10.180.103.138 with SMTP id fw10mr2153107wib.11.1357662018276;
        Tue, 08 Jan 2013 08:20:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.137 with SMTP id f9ls356913wie.2.gmail; Tue, 08 Jan
 2013 08:20:12 -0800 (PST)
X-Received: by 10.204.157.144 with SMTP id b16mr2480069bkx.4.1357662012366;
        Tue, 08 Jan 2013 08:20:12 -0800 (PST)
X-Received: by 10.204.157.144 with SMTP id b16mr2480068bkx.4.1357662012343;
        Tue, 08 Jan 2013 08:20:12 -0800 (PST)
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com [209.85.215.45])
        by gmr-mx.google.com with ESMTPS id 7si4614829bkr.3.2013.01.08.08.20.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 08:20:12 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 209.85.215.45 as permitted sender) client-ip=209.85.215.45;
Received: by mail-la0-f45.google.com with SMTP id ep20so677321lab.18
        for <msysgit@googlegroups.com>; Tue, 08 Jan 2013 08:20:12 -0800 (PST)
X-Received: by 10.152.124.15 with SMTP id me15mr62851998lab.5.1357662011927;
        Tue, 08 Jan 2013 08:20:11 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id to7sm20872315lab.13.2013.01.08.08.20.09
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 08:20:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@gmail.com designates 209.85.215.45 as permitted
 sender) smtp.mail=karsten.blees@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212973>

Am 04.01.2013 22:57, schrieb Erik Faye-Lund:
> On Fri, Jan 4, 2013 at 9:28 PM, Karsten Blees <karsten.blees@gmail.com> w=
rote:
>> On WinXP, the windows credential helper doesn't work at all (due to miss=
ing
>> Cred[Un]PackAuthenticationBuffer APIs). On Win7, the credential format u=
sed
>> by wincred is incompatible with native Windows tools (such as the contro=
l
>> panel applet or 'cmdkey.exe /generic'). These Windows tools only set the
>> TargetName, UserName and CredentialBlob members of the CREDENTIAL
>> structure (where CredentialBlob is the UTF-16-encoded password).
>>
>> Remove the unnecessary packing / unpacking of the password, along with t=
he
>> related API definitions, for compatibility with Windows XP.
>>
>> Don't use CREDENTIAL_ATTRIBUTEs to identify credentials for compatibilit=
y
>> with Windows credential manager tools. Parse the protocol, username, hos=
t
>> and path fields from the credential's target name instead.
>>
>> While we're at it, optionally accept CRLF (instead of LF only) to simpli=
fy
>> debugging in bash / cmd.
>>
>> Signed-off-by: Karsten Blees <blees@dcon.de>
>> ---
>>
>> Hi,
>>
>> I tried the windows credential helper yesterday and found that it doesn'=
t work on XP at all, and doesn't work properly in combination with Win7 cre=
dential manager tools. So here's a patch that reduces it to the functionali=
ty provided / expected by Windows.
>>
>> @Erik, Jeff: Please let me know if I'm missing something and the use of =
Cred[Un]PackAuthenticationBuffer or CREDENTIAL_ATTRIBUTEs actually served a=
 useful purpose.
>>
>=20
> The only reason why I used Cred[Un]PackAuthenticationBuffer, were that
> I wasn't aware that it was possible any other way. I didn't even know
> there was a Windows Credential Manager in Windows XP.
>=20

I believe the Cred* API was introduced in Win2k. The XP control panel apple=
t supports domain credentials only, but cmdkey.exe from Windows Server 2003=
 can be used on XP to manage generic credentials.

> The credential attributes were because they were convenient, and I'm
> not sure I understand what you mean about the Win7 credential manager
> tools. I did test my code with it - in fact, it was a very useful tool
> for debugging the helper.
>=20
> Are you referring to the credentials not *looking* like normal
> HTTP-credentials?

No, I was referring to creating / editing git credentials with Windows tool=
s manually. For example, changing your password in control panel removes al=
l credential attributes, so the current wincred won't find them any longer.=
..same for git credentials created e.g. via 'cmdkey /generic:git:http://me@=
example.com /user:me /pass:secret'.

The 'puzzling' part is that those credentials *look* exactly the same as if=
 created by wincred, but they don't work. And wincred isn't exactly verbose=
 in its error messages :-)

> But, if we do any of these changes, does this mean I will lose my
> existing credentials? It's probably not a big deal, but it's worth a
> mention, isn't it?
>=20

Yes, existing stored credentials are lost after this patch. Will add a note=
 to the commit message.

We _could_ try to detect the old format, but I don't think it's worth the t=
rouble.

>> @@ -67,20 +61,14 @@ typedef struct _CREDENTIALW {
>>  #define CRED_MAX_ATTRIBUTES 64
>>
>>  typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
>> -typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, D=
WORD,
>> -    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
>>  typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
>>      PCREDENTIALW **);
>> -typedef BOOL (WINAPI *CredPackAuthenticationBufferWT)(DWORD, LPWSTR, LP=
WSTR,
>> -    PBYTE, DWORD *);
>>  typedef VOID (WINAPI *CredFreeT)(PVOID);
>>  typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
>>
>>  static HMODULE advapi, credui;
>=20
> Perhaps get rid of credui also?
>=20

Good catch

>>  static CredWriteWT CredWriteW;
>> -static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW=
;
>>  static CredEnumerateWT CredEnumerateW;
>> -static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
>>  static CredFreeT CredFree;
>>  static CredDeleteWT CredDeleteW;
>>
>> @@ -88,74 +76,64 @@ static void load_cred_funcs(void)
>>  {
>>         /* load DLLs */
>>         advapi =3D LoadLibrary("advapi32.dll");
>> -       credui =3D LoadLibrary("credui.dll");
>> -       if (!advapi || !credui)
>> +       if (!advapi)
>>                 die("failed to load DLLs");
>=20
> It's not multiple DLLs any more, so perhaps "failed to load
> advapi32.dll" instead?
>=20

Certainly

>> -static char target_buf[1024];
>> -static char *protocol, *host, *path, *username;
>> -static WCHAR *wusername, *password, *target;
>> +static WCHAR *wusername, *password, *protocol, *host, *path, target[102=
4];
>>
>> -static void write_item(const char *what, WCHAR *wbuf)
>> +static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>>  {
>>         char *buf;
>> -       int len =3D WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, N=
ULL,
>> +       int len =3D WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, NULL, 0,=
 NULL,
>>             FALSE);
>>         buf =3D xmalloc(len);
>>
>> -       if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, F=
ALSE))
>> +       if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, buf, len, NULL,=
 FALSE))
>>                 die("WideCharToMultiByte failed!");
>>
>>         printf("%s=3D", what);
>> -       fwrite(buf, 1, len - 1, stdout);
>> +       fwrite(buf, 1, len, stdout);
>>         putchar('\n');
>>         free(buf);
>>  }
>>
>=20
> When the password-blob is simply UTF-16 encoded, are the
> zero-termination not included? That's the reason for this change,
> right?
>=20

Yes, the Windows tools store the password without trailing \0.

>> -static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
>> -    const char *want)
>> +static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>>  {
>> -       int i;
>> -       if (!want)
>> -               return 1;
>> -
>> -       for (i =3D 0; i < cred->AttributeCount; ++i)
>> -               if (!wcscmp(cred->Attributes[i].Keyword, keyword))
>> -                       return !strcmp((const char *)cred->Attributes[i]=
.Value,
>> -                           want);
>> -
>> -       return 0; /* not found */
>> +       LPCWSTR start =3D *ptarget;
>> +       LPCWSTR end =3D *delim ? wcsstr(start, delim) : start + wcslen(s=
tart);
>> +       int len =3D end ? end - start : wcslen(start);
>> +       /* update ptarget if we either found a delimiter or need a match=
 */
>> +       if (end || want)
>> +               *ptarget =3D end ? end + wcslen(delim) : start + len;
>> +       return !want || (!wcsncmp(want, start, len) && !want[len]);
>>  }
>>
>=20
> I'm a bit tired now, but I'm having a hard time reading this code.
> Right now it seems it's a bit too ternary-expression heavy for my
> taste, though.
>=20

OK, I'll flesh that out a bit. Perhaps a few more comments wouldn't hurt ei=
ther.

>>  static int match_cred(const CREDENTIALW *cred)
>>  {
>> -       return (!wusername || !wcscmp(wusername, cred->UserName)) &&
>> -           match_attr(cred, L"git_protocol", protocol) &&
>> -           match_attr(cred, L"git_host", host) &&
>> -           match_attr(cred, L"git_path", path);
>> +       LPCWSTR target =3D cred->TargetName;
>> +       if (wusername && wcscmp(wusername, cred->UserName))
>> +               return 0;
>> +
>> +       return match_part(&target, L"git", L":") &&
>> +               match_part(&target, protocol, L"://") &&
>> +               match_part(&target, wusername, L"@") &&
>> +               match_part(&target, host, L"/") &&
>> +               match_part(&target, path, L"");
>>  }
>>
>=20
> Ugh, it feels a bit wrong to store and verify the username twice. Do
> we really have to?
>=20
> The target needs to be unique, even if two different usernames are
> stored for the same site under the same conditions. So probably. It
> just doesn't feel quite right.
>=20

I don't really see why you would need several usernames to connect to the s=
ame target. I can imagine different credentials for reading / writing, but =
then the protocol would usually be different as well, wouldn't it? (e.g. ht=
tp vs. ssh)

One of my interim solutions was to remove the username part from the URL en=
tirely. That enabled me to change credentials in control panel (including t=
he username), and wincred would use them. However, that version failed the =
'helper can store multiple users' test, so I ended up with storing / checki=
ng username twice.

>> @@ -165,44 +143,15 @@ static void get_credential(void)
>>         /* search for the first credential that matches username */
>>         for (i =3D 0; i < num_creds; ++i)
>>                 if (match_cred(creds[i])) {
>> -                       cred =3D creds[i];
>> +                       write_item("username", creds[i]->UserName,
>> +                               wcslen(creds[i]->UserName));
>> +                       write_item("password",
>> +                               (LPCWSTR)creds[i]->CredentialBlob,
>> +                               creds[i]->CredentialBlobSize / sizeof(WC=
HAR));
>>                         break;
>>                 }
>> -       if (!cred)
>> -               return;
>> -
>> -       CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
>> -           cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
>> -           NULL, &pass_buf_size);
>> -
>> -       user_buf =3D xmalloc(user_buf_size * sizeof(WCHAR));
>> -       pass_buf =3D xmalloc(pass_buf_size * sizeof(WCHAR));
>> -
>> -       if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
>> -           cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NU=
LL,
>> -           pass_buf, &pass_buf_size))
>> -               die("CredUnPackAuthenticationBuffer failed");
>>
>>         CredFree(creds);
>> -
>> -       /* zero-terminate (sizes include zero-termination) */
>> -       user_buf[user_buf_size - 1] =3D L'\0';
>> -       pass_buf[pass_buf_size - 1] =3D L'\0';
>> -
>> -       write_item("username", user_buf);
>> -       write_item("password", pass_buf);
>> -
>> -       free(user_buf);
>> -       free(pass_buf);
>> -}
>=20
> Nice!
>=20
>> -
>> -static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keywor=
d,
>> -    const char *value)
>> -{
>> -       attr->Keyword =3D (LPWSTR)keyword;
>> -       attr->Flags =3D 0;
>> -       attr->ValueSize =3D strlen(value) + 1; /* store zero-termination=
 */
>> -       attr->Value =3D (LPBYTE)value;
>>  }
>>
>>  static void store_credential(void)
>> @@ -215,40 +164,18 @@ static void store_credential(void)
>>         if (!wusername || !password)
>>                 return;
>>
>> -       /* query buffer size */
>> -       CredPackAuthenticationBufferW(0, wusername, password,
>> -           NULL, &auth_buf_size);
>> -
>> -       auth_buf =3D xmalloc(auth_buf_size);
>> -
>> -       if (!CredPackAuthenticationBufferW(0, wusername, password,
>> -           auth_buf, &auth_buf_size))
>> -               die("CredPackAuthenticationBuffer failed");
>> -
>>         cred.Flags =3D 0;
>>         cred.Type =3D CRED_TYPE_GENERIC;
>>         cred.TargetName =3D target;
>>         cred.Comment =3D L"saved by git-credential-wincred";
>> -       cred.CredentialBlobSize =3D auth_buf_size;
>> -       cred.CredentialBlob =3D auth_buf;
>> +       cred.CredentialBlobSize =3D (wcslen(password)) * sizeof(WCHAR);
>> +       cred.CredentialBlob =3D (LPVOID)password;
>>         cred.Persist =3D CRED_PERSIST_LOCAL_MACHINE;
>> -       cred.AttributeCount =3D 1;
>> -       cred.Attributes =3D attrs;
>> +       cred.AttributeCount =3D 0;
>> +       cred.Attributes =3D NULL;
>>         cred.TargetAlias =3D NULL;
>>         cred.UserName =3D wusername;
>>
>> -       write_attr(attrs, L"git_protocol", protocol);
>> -
>> -       if (host) {
>> -               write_attr(attrs + cred.AttributeCount, L"git_host", hos=
t);
>> -               cred.AttributeCount++;
>> -       }
>> -
>> -       if (path) {
>> -               write_attr(attrs + cred.AttributeCount, L"git_path", pat=
h);
>> -               cred.AttributeCount++;
>> -       }
>> -
>>         if (!CredWriteW(&cred, 0))
>>                 die("CredWrite failed");
>>  }
>=20
> Nice.
>=20
>> @@ -284,10 +211,13 @@ static void read_credential(void)
>>
>>         while (fgets(buf, sizeof(buf), stdin)) {
>>                 char *v;
>> +               int len =3D strlen(buf);
>> +               /* strip trailing CR / LF */
>> +               while (len && strchr("\r\n", buf[len - 1]))
>> +                       buf[--len] =3D 0;
>>
>> -               if (!strcmp(buf, "\n"))
>> +               if (!*buf)
>>                         break;
>> -               buf[strlen(buf)-1] =3D '\0';
>>
>>                 v =3D strchr(buf, '=3D');
>>                 if (!v)
>=20
> I think this part deserves a separate patch, no?
>=20

Sigh...I thought I could get away without doing a patch series :-)

>> @@ -295,13 +225,12 @@ static void read_credential(void)
>>                 *v++ =3D '\0';
>>
>>                 if (!strcmp(buf, "protocol"))
>> -                       protocol =3D xstrdup(v);
>> +                       protocol =3D utf8_to_utf16_dup(v);
>>                 else if (!strcmp(buf, "host"))
>> -                       host =3D xstrdup(v);
>> +                       host =3D utf8_to_utf16_dup(v);
>>                 else if (!strcmp(buf, "path"))
>> -                       path =3D xstrdup(v);
>> +                       path =3D utf8_to_utf16_dup(v);
>>                 else if (!strcmp(buf, "username")) {
>> -                       username =3D xstrdup(v);
>>                         wusername =3D utf8_to_utf16_dup(v);
>>                 } else if (!strcmp(buf, "password"))
>>                         password =3D utf8_to_utf16_dup(v);
>=20
> So, you need the strings as UTF-16 instead so you can match against them.=
..
>=20

Exactly

>> @@ -330,22 +259,20 @@ int main(int argc, char *argv[])
>>                 return 0;
>>
>>         /* prepare 'target', the unique key for the credential */
>> -       strncat(target_buf, "git:", sizeof(target_buf));
>> -       strncat(target_buf, protocol, sizeof(target_buf));
>> -       strncat(target_buf, "://", sizeof(target_buf));
>> -       if (username) {
>> -               strncat(target_buf, username, sizeof(target_buf));
>> -               strncat(target_buf, "@", sizeof(target_buf));
>> +       wcscpy(target, L"git:");
>> +       wcsncat(target, protocol, ARRAY_SIZE(target));
>> +       wcsncat(target, L"://", ARRAY_SIZE(target));
>> +       if (wusername) {
>> +               wcsncat(target, wusername, ARRAY_SIZE(target));
>> +               wcsncat(target, L"@", ARRAY_SIZE(target));
>>         }
>>         if (host)
>> -               strncat(target_buf, host, sizeof(target_buf));
>> +               wcsncat(target, host, ARRAY_SIZE(target));
>>         if (path) {
>> -               strncat(target_buf, "/", sizeof(target_buf));
>> -               strncat(target_buf, path, sizeof(target_buf));
>> +               wcsncat(target, L"/", ARRAY_SIZE(target));
>> +               wcsncat(target, path, ARRAY_SIZE(target));
>>         }
>>
>> -       target =3D utf8_to_utf16_dup(target_buf);
>> -
>=20
> ...Which means that you are composing a UTF-16 target directly rather
> than ASCII. Looks sane.
>=20

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
