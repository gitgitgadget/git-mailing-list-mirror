Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbpcbSij"
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F6170E
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 00:00:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0064353af8so523142466b.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 00:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700812803; x=1701417603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7jKpG/Ywq2I7l4VGT+L8j1CxIKooQcJORNUKhgyD4C4=;
        b=SbpcbSijOe5CfPHTmiWbLAnDTaeWpEfXq6caj0yWI8WLAMbb7xi34AHLdrslQwPNbU
         Wa8Cgv0Qkg3O8QRJxP4Tz911X6aB1YqGQvJs3m9rYkClK2B1krqnT5jnPZcKn5COJuxr
         0gi+EGcZggE3dKWq3cWoVIGno96Nfb7BSpu+Ibtb8eqDGP2QQldlqCRFtz39rrA1dVRD
         fyW+u4O2MBcK8KDELRAGZFbJa2bi9DcjwjsYwDBLUwisVTZNnD/LxzoAWe4gm/wLHtpd
         hZzaric28mxkfaVCSsEQFVJKTHWH55vhJsPJ7e3/ZD/AufcvRX3GtDeifg6yb/CVq1pR
         Ra6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812803; x=1701417603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jKpG/Ywq2I7l4VGT+L8j1CxIKooQcJORNUKhgyD4C4=;
        b=UvKIW36KED/8z/QrsL6q9OIqrRcvSXVBuh1/P7RRxx/QHMQceL5j7CpmGBjypmHdCw
         VgyFGKzyr2w2qp2I/IVKCha2iJt9IsF0MTBBL9Y3Q1G5Ra/if2A8SrhGH9CGS6NVsB46
         XeUhA4jisqlyQ/oUXdSX0eQtMzdjEWTzkGmN7WCyO9SSPnyNepaCoHw1a4rzynskmGqk
         d7wltDpn++G75gTnLZdCZhYIM3+ZZUtTO23+S0tGakl+VRVsVISPoonUPUIr9xncFxmw
         MsDu0LTEk5QY4GjoAWR+pOUpPfbXt9iqnBUYt1/2AJh3sSmZKQ7foUVdCnAnXbVqAL8U
         fS8g==
X-Gm-Message-State: AOJu0YwYmg4ZbROPEmgRHqKF2hOZ4ZoEAfYGQZQQ6adDwxcBADdFCSGe
	VLI1zsEr87HBxcjv+nspb3MxXAMrGZD8SeeOaQRtdy8R
X-Google-Smtp-Source: AGHT+IG1InGBTo9uA9togrtHqmZghaiL2pfqRQ7w7NnGCm2XhlL6dbcVhxGgOIPZ3MEi4K13Bx9n7gi8t7Tu8gWK2jQ=
X-Received: by 2002:a17:906:11e:b0:a01:ae9a:c1d3 with SMTP id
 30-20020a170906011e00b00a01ae9ac1d3mr1667637eje.11.1700812803096; Fri, 24 Nov
 2023 00:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
 <pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com> <xmqqbkbwzss5.fsf@gitster.g>
In-Reply-To: <xmqqbkbwzss5.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 24 Nov 2023 08:00:00 +0000
Message-ID: <CAGJzqskEM_ub9arQBAhem+cQ0R4jGqQUoN_DZ7w5FRS3hK=bpw@mail.gmail.com>
Subject: Re: [PATCH v2] credential/wincred: store oauth_refresh_token
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>, 
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>, 
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, patthoyts@gmail.com, 
	=?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Nov 2023 at 07:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> "M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > a5c7656 (credential: new attribute oauth_refresh_token) introduced
> > a new confidential credential attribute for helpers to store.
> >
> > We encode the new attribute in the CredentialBlob, separated by
> > newline:
> >
> >     hunter2
> >     oauth_refresh_token=xyzzy
> >
> > This is extensible and backwards compatible. The credential protocol
> > already assumes that attribute values do not contain newlines.
> >
> > This fixes test "helper (wincred) gets oauth_refresh_token" when
> > t0303-credential-external.sh is run with
> > GIT_TEST_CREDENTIAL_HELPER=wincred. This test was added in a5c76569e7
> > (credential: new attribute oauth_refresh_token, 2023-04-21).
> >
> > Alternatives considered: store oauth_refresh_token in a wincred
> > attribute. This would be insecure because wincred assumes attribute
> > values to be non-confidential.
>
> Earlier, a5c76569 (credential: new attribute oauth_refresh_token,
> 2023-04-21) built the "git" side support for the token, and taught
> credential-cache to store the necessary information.  Then 0ce02e2f
> (credential/libsecret: store new attributes, 2023-06-16) was written
> for libsecret to support the same interface.
>
> And this one adds corresponding support for wincred.  Do I
> understand what is going on around this patch correctly?

Yes, that's right.


>
> I do not do Windows, but some people on this list certainly do and
> would be capable of giving the patch a necessary nudge ;-)
>
> Thanks.
>
> >  .../wincred/git-credential-wincred.c          | 46 ++++++++++++++++---
> >  1 file changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> > index 4cd56c42e24..5c6a7d65d4a 100644
> > --- a/contrib/credential/wincred/git-credential-wincred.c
> > +++ b/contrib/credential/wincred/git-credential-wincred.c
> > @@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
> >  }
> >
> >  static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
> > -     *password_expiry_utc;
> > +     *password_expiry_utc, *oauth_refresh_token;
> >
> >  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
> >  {
> > @@ -140,6 +140,11 @@ static void get_credential(void)
> >       DWORD num_creds;
> >       int i;
> >       CREDENTIAL_ATTRIBUTEW *attr;
> > +     WCHAR *secret;
> > +     WCHAR *line;
> > +     WCHAR *remaining_lines;
> > +     WCHAR *part;
> > +     WCHAR *remaining_parts;
> >
> >       if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
> >               return;
> > @@ -149,9 +154,23 @@ static void get_credential(void)
> >               if (match_cred(creds[i], 0)) {
> >                       write_item("username", creds[i]->UserName,
> >                               creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
> > -                     write_item("password",
> > -                             (LPCWSTR)creds[i]->CredentialBlob,
> > -                             creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                     if (creds[i]->CredentialBlobSize > 0) {
> > +                             secret = xmalloc(creds[i]->CredentialBlobSize);
> > +                             wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                             line = wcstok_s(secret, L"\r\n", &remaining_lines);
> > +                             write_item("password", line, line ? wcslen(line) : 0);
> > +                             while(line != NULL) {
> > +                                     part = wcstok_s(line, L"=", &remaining_parts);
> > +                                     if (!wcscmp(part, L"oauth_refresh_token")) {
> > +                                             write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
> > +                                     }
> > +                                     line = wcstok_s(NULL, L"\r\n", &remaining_lines);
> > +                             }
> > +                     } else {
> > +                             write_item("password",
> > +                                             (LPCWSTR)creds[i]->CredentialBlob,
> > +                                             creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                     }
> >                       for (int j = 0; j < creds[i]->AttributeCount; j++) {
> >                               attr = creds[i]->Attributes + j;
> >                               if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
> > @@ -160,6 +179,7 @@ static void get_credential(void)
> >                                       break;
> >                               }
> >                       }
> > +                     free(secret);
> >                       break;
> >               }
> >
> > @@ -170,16 +190,26 @@ static void store_credential(void)
> >  {
> >       CREDENTIALW cred;
> >       CREDENTIAL_ATTRIBUTEW expiry_attr;
> > +     WCHAR *secret;
> > +     int wlen;
> >
> >       if (!wusername || !password)
> >               return;
> >
> > +     if (oauth_refresh_token) {
> > +             wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> > +             secret = xmalloc(sizeof(WCHAR) * wlen);
> > +             _snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> > +     } else {
> > +             secret = _wcsdup(password);
> > +     }
> > +
> >       cred.Flags = 0;
> >       cred.Type = CRED_TYPE_GENERIC;
> >       cred.TargetName = target;
> >       cred.Comment = L"saved by git-credential-wincred";
> > -     cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
> > -     cred.CredentialBlob = (LPVOID)password;
> > +     cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
> > +     cred.CredentialBlob = (LPVOID)_wcsdup(secret);
> >       cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
> >       cred.AttributeCount = 0;
> >       cred.Attributes = NULL;
> > @@ -194,6 +224,8 @@ static void store_credential(void)
> >       cred.TargetAlias = NULL;
> >       cred.UserName = wusername;
> >
> > +     free(secret);
> > +
> >       if (!CredWriteW(&cred, 0))
> >               die("CredWrite failed");
> >  }
> > @@ -265,6 +297,8 @@ static void read_credential(void)
> >                       password = utf8_to_utf16_dup(v);
> >               else if (!strcmp(buf, "password_expiry_utc"))
> >                       password_expiry_utc = utf8_to_utf16_dup(v);
> > +             else if (!strcmp(buf, "oauth_refresh_token"))
> > +                     oauth_refresh_token = utf8_to_utf16_dup(v);
> >               /*
> >                * Ignore other lines; we don't know what they mean, but
> >                * this future-proofs us when later versions of git do
> >
> > base-commit: bc5204569f7db44d22477485afd52ea410d83743
