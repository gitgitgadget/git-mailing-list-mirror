Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34238F80
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411728; cv=none; b=tScNXLise5xSCmrNiO5vZLOy0ruuOAxD26g0ZVcNVQkAyQyExCFqS9iz06HQ/GeEieWoC8Ifod480sQDAh6Cq/HNg488kiPY8SMaNOifbg82h6s4iS8pZaVwLibkVfUsgk4Xrt92dxyFVBmwvMXbnMQj1Q8geun6Pz9kE2R211U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411728; c=relaxed/simple;
	bh=LPuoaQBvcVoTwbON7rztzTyOQ4ijRbrS3XJJlxMcPHk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DHPl8hR53UfU2/gey0BOGxcdgn2Uyn5R3gSqHpl9MyWLtKD6QlTqvCWG+XotuAFt27LjNwfhVZYZqkg5rkf5bprZa2LQ1INosa2E8X2W+wglSoxtAvjJY9NUKBZuRoEgzNhqsAhxZA3qVW7Hp9xkFp68oFQ3smzkgkG9LEnRvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=keylock.net; spf=none smtp.mailfrom=keylock.net; dkim=pass (2048-bit key) header.d=keylock-net.20230601.gappssmtp.com header.i=@keylock-net.20230601.gappssmtp.com header.b=1VG46Bkv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=keylock.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=keylock.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keylock-net.20230601.gappssmtp.com header.i=@keylock-net.20230601.gappssmtp.com header.b="1VG46Bkv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3618829f8f.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=keylock-net.20230601.gappssmtp.com; s=20230601; t=1743411724; x=1744016524; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5zxj0LF0Uuy2c8yTUOV8cB8ftDFmJvIKgHmjqBlaFo=;
        b=1VG46BkvngudTvRHL/ynRafe+6wshy6+USe+nE97DmWCoVsU+efYKAhWd3ASanktJA
         vPZsmxRMwPr2vKX0+w9jL2ufs/KfR0w6GP+EAMhoMabTTmPUiD+IhBbUQFyRVL+ZArZD
         OYAApvM7ZkJjpoNrpbvorOz1eVb1AGxtD2gdbQRBa/BBuBE9uq9oswoEEpmSOHeAaKHh
         ewa5MmDVibTHBIw8lDrdbyWP7I1FQhdMDtL6L7tiWreh7erWQ1Ax6KyTkFWJBNXUjWDd
         NrIe1aMUmQOGAY0MsXoWAB+YKCV7Bjnag1QZFLAZ1jyC9IWpoXKh/RaEYIqMX05zIxaJ
         EoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743411724; x=1744016524;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5zxj0LF0Uuy2c8yTUOV8cB8ftDFmJvIKgHmjqBlaFo=;
        b=IEYHsVvnC/Q5c5nnBgIaAJXiXbwuh8fgyxqT69drNype11Lk2WhizYV1NTD7pQLtEt
         Dlb5QL8q3QKZQlG/csta2xWpSN9J2ThpvJtk58hkrgmCUbY+dPSqQWfhQXnz1Hs0s8Wm
         lcREqeV+YETJGFmgNJBTxNUfUYgFnTg+WhwOyMTuHl6m/JcV6EEQAs1gH/ylH7lP/F7H
         QeP1tVXB11jpkSW9xxbxU+nnRdDV+bMLslwLM9I85Z3j36LTnEqqs6nRtamYAKHuGBLg
         OwnRn1fNG2Xe4i/hdEwd20jLdv2+uNy/QPV+azncp5tQGVut1Y3oHm3/vohfTOE+2Igf
         AyNg==
X-Gm-Message-State: AOJu0Yxo82T+Tbr/RVa+yRwNjgfDziPr1sEoZiqToBEL4zBvVm7NELhH
	3yEx29wpRi9P49Iv3Zb20TQUou+CDakwAIL1mPLXRM0ghvp45oOC0reF6nsiPQ==
X-Gm-Gg: ASbGncubxCS7m4Y55ivG1heeAlmmfr4x29RxJdxVJel4pFR8UHwATZJ4Xno2tYy5Nox
	ycoYQPzYD76F9iMqLGLFjLwh657HNSi72LGopTNqmAKFwGxCOP4G+RvFdAeWw1+wMTBGuBgqZBI
	/NkX0t1xp973atlVuET73xGpev2wLWOxGp/q3uvqlQdpOyluBRU8k/e1jxSp10JY7W/GZoQRk5y
	ncpPpBRmtGv+p6lTYnPDwpd1OiJOJhFVWCKntUxxKuaykRrXais7MWJCNOYBYwLvC2u1RDQAnHK
	9vtFVaXiETxAtyMGwzYX/g+uxvGqfuWI2W35Q+hoeZ/W6CaWYjNwg3zkwZV2
X-Google-Smtp-Source: AGHT+IHu/qDjcnoNuPs4N/I0x7MAcH7Xqp/35xmAU+L5oDvpfAbd4lapRLCi+/cftYr3q/CQx8v88g==
X-Received: by 2002:a05:6000:2511:b0:39c:13fd:e50e with SMTP id ffacd0b85a97d-39c13fde631mr6006367f8f.10.1743411723433;
        Mon, 31 Mar 2025 02:02:03 -0700 (PDT)
Received: from smtpclient.apple ([130.164.141.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b663617sm10793908f8f.34.2025.03.31.02.02.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Mar 2025 02:02:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] git p4 fix for failure to decode p4 errors
From: Fahad Al-Rashed <fahad@keylock.net>
In-Reply-To: <652def28-2e97-4177-9197-bd93caa57886@gmail.com>
Date: Mon, 31 Mar 2025 12:01:50 +0300
Cc: git@vger.kernel.org,
 bekenn@gmai.com,
 ps@pks.im,
 phillip.wood@dunelm.org.uk
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1896FA9-F09C-4099-8A7E-4AFFD2DBCF7F@keylock.net>
References: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
 <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
 <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
 <339b8557-d41a-4a40-912b-eb2cff63159f@gmail.com>
 <7e5d0613-d116-4e60-8ccf-efb092776398@gmail.com>
 <652def28-2e97-4177-9197-bd93caa57886@gmail.com>
To: Nikolay.Shustov@gmail.com
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi Nikolay,

The patch looks reasonable.=20

What I can help with is test it on our Perforce installation when I go =
back to work next week.

For the purpose of testing, is running t/t9837-git-p4-error-encoding.sh =
locally on my computer enough to test your patch?

Best,
Fahad

> On 31 Mar 2025, at 4:21=E2=80=AFAM, Nikolay Shustov =
<nikolay.shustov@gmail.com> wrote:
>=20
> <adding Fahad Alrashed, James Touton and Patrick Steinhardt, whom Git =
points to as the contributors to the latest p4-git logic changes>
>=20
> Hello,
> May I ask you to review the below change to p4-git?
>=20
> Thank you in advance,
> - Nikolay
>=20
> On 3/30/25 16:06, Nikolay Shustov wrote:
>> Hi Phillip,
>> Thank you for your time and your feedback.
>> It is especially valuable to me as it is the very first PR of mine.
>> I will try to contact the recent contributors of git-p4 changes for =
review.
>>=20
>> To clarify on the fix:
>>=20
>> The error I hit was while using "git p4 clone":
>> It was throwing decoding exception at line 901 of git-p4, preventing =
import from Perforce depot to complete successfully.
>> The root cause is the logic for "git p4 clone" anticipates some p4 =
operations may return errors, it is a normal part of import process.
>> But that logic uses just .decode() on the byte array of the returned =
error message, which does not work well when it contains the characters =
with high bit set (which may be the case when Perforce configured =
without unicode support). git-p4 implementation has a decoding fallback =
logic for such cases in other places, but this specific place did not =
use any.
>>=20
>> Using the bullet list in description was not intended to enumerate =
the separate changes, but rather to highlight the details of the change.
>> I will make sure I won't use it in the future to avoid the confusion.
>>=20
>> That small refactoring I did was not a sidecar but a way I chose to =
implement the changes:
>> There was an existing function that was doing the job of decoding the =
received p4 metadata, using the existing git-p4 configuration settings.
>> There also were a few existing variables that kept the state between =
the calls of that function (e.g. indicator not to show decoding fallback =
warning twice, configuration settings).
>> However, with the way the function was implemented, it could not be =
reused as-is for the new case.
>> I would had to add a new function that would have to use the same =
core transcoding implementation but behave differently.
>> Adding behavior variances into the existing function felt suboptimal: =
it would complicate it quite a bit and I felt sorry about next one who =
will have to reverse engineer its behavior again. Duplicating the part =
of logic of the existing function also looked suboptimal: any further =
changes would have to be done in two places.
>> So, seeing the need in keeping state between calls and separating a =
part of existing logic into separate functions, I went for moving the =
implementation into a new class and organizing things there with the =
class instance. In my opinion, the new code looks pretty =
self-descritpitve.
>>=20
>> Thank you,
>> - Nikolay
>>=20
>> On 3/26/25 11:09, Phillip Wood wrote:
>>> Hi Nikolay
>>>=20
>>> On 25/03/2025 23:09, Nikolay Shustov wrote:
>>>> I think this fix is important.
>>>> git-p4 is used in the companies where there is an intent to migrate =
from Perforce to Git and having the issue that this change fixes is a =
real roadblock.
>>>> The better we can make git-p4, the more adoption Git would get in =
the commercial world.
>>>=20
>>> Unfortunately I don't think any of the regular git contributors use =
git-p4 so to find someone to review this patch I would look at who has =
contributed to git-p4 recently and cc them. Before you do that I have a =
couple of suggestions below
>>>=20
>>>> On 3/22/25 07:48, Nikolay Shustov wrote:
>>>>> ping, pretty please? :-)
>>>>>=20
>>>>> On 3/19/25 23:20, Nikolay Shustov via GitGitGadget wrote:
>>>>>> From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>>>>>=20
>>>>>> Fixes the git p4 failure happening when Perforce command returns =
error
>>>>>> containing byte stream of characters with high bit set. In such =
situations
>>>>>> git p4 implementatino fails to decode this byte stream into utf-8 =
string.
>>>>>>=20
>>>>>> Design:
>>>>>> Make use of existing decoding fallback strategy, described by
>>>>>> git-p4.metadataDecodingStrategy and =
git-p4.metadataFallbackEncoding
>>>>>> settings in the logic that decodes the Perforce command error =
bytes.
>>>=20
>>> Our usual style for commit messages is to explain what the problem =
is and how it is fixed by the changes in the patch. Rather than saying =
"fixes the git p4 failure" I would start by explaining what that failure =
is and how it is caused. It would also be helpful to explain what the =
settings that you refer to do so that someone who is familiar with =
python but not with git-p4 can understand and potentially review the =
changes.
>>>=20
>>>>>> Details:
>>>>>> - Moved p4 metadata transcoding logic from
>>>>>>    metadata_stream_to_writable_bytes(..) into a new =
MetadataTranscoder class.
>>>>>> - Enhcanced the implementation to use =
git-p4.metadataDecodingStrategy and
>>>>>>    git-p4.metadataFallbackEncoding settings for p4 errors =
decoding.
>>>>>> - Added test.
>>>=20
>>> Thanks for taking the time to add a new test, it is much =
appreciated. When there is a bullet list in a commit message it is often =
a sign that the commit is doing more than one thing at once. In this =
case it appears there is a bug fix mixed in with some refactoring. I =
would split the refactoring out into a preparatory patch so that reviews =
can clearly see which changes are due to creating the MetadataTranscoder =
class and which are the changes that fix the bug. The new test should be =
added in the commit that fixes the bug.
>>>=20
>>> Best Wishes
>>>=20
>>> Phillip
>>>=20
>>>>>> Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>>>>> ---
>>>>>>      git p4 fix for failure to decode p4 errors
>>>>>>=20
>>>>>> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr- =
git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
>>>>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr- =
git-1926/nshustov/git-p4-error-decoding-v1
>>>>>> Pull-Request: https://github.com/git/git/pull/1926
>>>>>>=20
>>>>>>   git-p4.py                        | 135 =
++++++++++++++++++-------------
>>>>>>   t/meson.build                    |   1 +
>>>>>>   t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
>>>>>>   t/t9837/git-p4-error-python3.py  |  15 ++++
>>>>>>   4 files changed, 149 insertions(+), 55 deletions(-)
>>>>>>   create mode 100755 t/t9837-git-p4-error-encoding.sh
>>>>>>   create mode 100644 t/t9837/git-p4-error-python3.py
>>>>>>=20
>>>>>> diff --git a/git-p4.py b/git-p4.py
>>>>>> index c0ca7becaf4..72a4c55f99e 100755
>>>>>> --- a/git-p4.py
>>>>>> +++ b/git-p4.py
>>>>>> @@ -234,67 +234,91 @@ else:
>>>>>>       class MetadataDecodingException(Exception):
>>>>>> -    def __init__(self, input_string):
>>>>>> +    def __init__(self, input_string, error=3DNone):
>>>>>>           self.input_string =3D input_string
>>>>>> +        self.error =3D error
>>>>>>         def __str__(self):
>>>>>> -        return """Decoding perforce metadata failed!
>>>>>> +        message =3D """Decoding perforce metadata failed!
>>>>>>   The failing string was:
>>>>>>   ---
>>>>>>   {}
>>>>>>   ---
>>>>>>   Consider setting the git-p4.metadataDecodingStrategy config =
option to
>>>>>>   'fallback', to allow metadata to be decoded using a fallback =
encoding,
>>>>>> -defaulting to cp1252.""".format(self.input_string)
>>>>>> +defaulting to cp1252."""
>>>>>> +        if verbose and self.error is not None:
>>>>>> +            message +=3D """
>>>>>> +---
>>>>>> +Error:
>>>>>> +---
>>>>>> +{}"""
>>>>>> +        return message.format(self.input_string, self.error)
>>>>>>     -encoding_fallback_warning_issued =3D False
>>>>>> -encoding_escape_warning_issued =3D False
>>>>>> -def metadata_stream_to_writable_bytes(s):
>>>>>> -    encodingStrategy =3D =
gitConfig('git-p4.metadataDecodingStrategy') or =
defaultMetadataDecodingStrategy
>>>>>> -    fallbackEncoding =3D =
gitConfig('git-p4.metadataFallbackEncoding') or =
defaultFallbackMetadataEncoding
>>>>>> -    if not isinstance(s, bytes):
>>>>>> -        return s.encode('utf_8')
>>>>>> -    if encodingStrategy =3D=3D 'passthrough':
>>>>>> -        return s
>>>>>> -    try:
>>>>>> -        s.decode('utf_8')
>>>>>> -        return s
>>>>>> -    except UnicodeDecodeError:
>>>>>> -        if encodingStrategy =3D=3D 'fallback' and =
fallbackEncoding:
>>>>>> -            global encoding_fallback_warning_issued
>>>>>> -            global encoding_escape_warning_issued
>>>>>> -            try:
>>>>>> -                if not encoding_fallback_warning_issued:
>>>>>> -                    print("\nCould not decode value as utf-8; =
using configured fallback encoding %s: %s" % (fallbackEncoding, s))
>>>>>> -                    print("\n(this warning is only displayed =
once during an import)")
>>>>>> -                    encoding_fallback_warning_issued =3D True
>>>>>> -                return =
s.decode(fallbackEncoding).encode('utf_8')
>>>>>> -            except Exception as exc:
>>>>>> -                if not encoding_escape_warning_issued:
>>>>>> -                    print("\nCould not decode value with =
configured fallback encoding %s; escaping bytes over 127: %s" % =
(fallbackEncoding, s))
>>>>>> -                    print("\n(this warning is only displayed =
once during an import)")
>>>>>> -                    encoding_escape_warning_issued =3D True
>>>>>> -                escaped_bytes =3D b''
>>>>>> -                # bytes and strings work very differently in =
python2 vs python3...
>>>>>> -                if str is bytes:
>>>>>> -                    for byte in s:
>>>>>> -                        byte_number =3D struct.unpack('>B', =
byte)[0]
>>>>>> -                        if byte_number > 127:
>>>>>> -                            escaped_bytes +=3D b'%'
>>>>>> -                            escaped_bytes +=3D hex(byte_number) =
[2:].upper()
>>>>>> -                        else:
>>>>>> -                            escaped_bytes +=3D byte
>>>>>> -                else:
>>>>>> -                    for byte_number in s:
>>>>>> -                        if byte_number > 127:
>>>>>> -                            escaped_bytes +=3D b'%'
>>>>>> -                            escaped_bytes +=3D =
hex(byte_number).upper().encode()[2:]
>>>>>> -                        else:
>>>>>> -                            escaped_bytes +=3D =
bytes([byte_number])
>>>>>> -                return escaped_bytes
>>>>>> +class MetadataTranscoder:
>>>>>> +    def __init__(self, default_metadata_decoding_strategy, =
default_fallback_metadata_encoding):
>>>>>> +        self.decoding_fallback_warning_issued =3D False
>>>>>> +        self.decoding_escape_warning_issued =3D False
>>>>>> +        self.decodingStrategy =3D gitConfig('git- =
p4.metadataDecodingStrategy') or default_metadata_decoding_strategy
>>>>>> +        self.fallbackEncoding =3D gitConfig('git- =
p4.metadataFallbackEncoding') or default_fallback_metadata_encoding
>>>>>> +
>>>>>> +    def decode_metadata(self, s, error_from_fallback=3DTrue):
>>>>>> +        try:
>>>>>> +            return [s.decode('utf_8'), 'utf_8']
>>>>>> +        except UnicodeDecodeError as decode_exception:
>>>>>> +            error =3D decode_exception
>>>>>> +            if self.decodingStrategy =3D=3D 'fallback' and =
self.fallbackEncoding:
>>>>>> +                try:
>>>>>> +                    if not =
self.decoding_fallback_warning_issued:
>>>>>> +                        print("\nCould not decode value as =
utf-8; using configured fallback encoding %s: %s" % =
(self.fallbackEncoding, s))
>>>>>> +                        print("\n(this warning is only displayed =
once during an import)")
>>>>>> + self.decoding_fallback_warning_issued =3D True
>>>>>> +                    return [s.decode(self.fallbackEncoding), =
self.fallbackEncoding]
>>>>>> +                except Exception as decode_exception:
>>>>>> +                    if not error_from_fallback:
>>>>>> +                        return [s, None]
>>>>>> +                    error =3D decode_exception
>>>>>> +            raise MetadataDecodingException(s, error)
>>>>>> +
>>>>>> +    def metadata_stream_to_writable_bytes(self, s):
>>>>>> +        if not isinstance(s, bytes):
>>>>>> +            return s.encode('utf_8')
>>>>>> +        if self.decodingStrategy =3D=3D 'passthrough':
>>>>>> +            return s
>>>>>> +
>>>>>> +        [text, encoding] =3D self.decode_metadata(s, False)
>>>>>> +        if encoding =3D=3D 'utf_8':
>>>>>> +            # s is of utf-8 already
>>>>>> +            return s
>>>>>> +
>>>>>> +        if encoding is None:
>>>>>> +            # could not decode s, even with fallback encoding
>>>>>> +            if not self.decoding_escape_warning_issued:
>>>>>> +                print("\nCould not decode value with configured =
fallback encoding %s; escaping bytes over 127: %s" % =
(self.fallbackEncoding, s))
>>>>>> +                print("\n(this warning is only displayed once =
during an import)")
>>>>>> +                self.decoding_escape_warning_issued =3D True
>>>>>> +            escaped_bytes =3D b''
>>>>>> +            # bytes and strings work very differently in python2 =
vs python3...
>>>>>> +            if str is bytes:
>>>>>> +                for byte in s:
>>>>>> +                    byte_number =3D struct.unpack('>B', byte)[0]
>>>>>> +                    if byte_number > 127:
>>>>>> +                        escaped_bytes +=3D b'%'
>>>>>> +                        escaped_bytes +=3D =
hex(byte_number)[2:].upper()
>>>>>> +                    else:
>>>>>> +                        escaped_bytes +=3D byte
>>>>>> +            else:
>>>>>> +                for byte_number in s:
>>>>>> +                    if byte_number > 127:
>>>>>> +                        escaped_bytes +=3D b'%'
>>>>>> +                        escaped_bytes +=3D =
hex(byte_number).upper().encode()[2:]
>>>>>> +                    else:
>>>>>> +                        escaped_bytes +=3D bytes([byte_number])
>>>>>> +            return escaped_bytes
>>>>>>   -        raise MetadataDecodingException(s)
>>>>>> +        # were able to decode but not to utf-8
>>>>>> +        return text.encode('utf_8')
>>>>>>       def decode_path(path):
>>>>>> @@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=3DNone, =
stdin_mode=3D'w+b', cb=3DNone, skip_info=3DFalse,
>>>>>>                       decoded_entry[key] =3D value
>>>>>>                   # Parse out data if it's an error response
>>>>>>                   if decoded_entry.get('code') =3D=3D 'error' and =
'data' in decoded_entry:
>>>>>> -                    decoded_entry['data'] =3D =
decoded_entry['data'].decode()
>>>>>> +                    decoded_entry['data'] =3D =
metadataTranscoder.decode_metadata(decoded_entry['data'])
>>>>>>                   entry =3D decoded_entry
>>>>>>               if skip_info:
>>>>>>                   if 'code' in entry and entry['code'] =3D=3D =
'info':
>>>>>>                       continue
>>>>>>               for key in p4KeysContainingNonUtf8Chars():
>>>>>>                   if key in entry:
>>>>>> -                    entry[key] =3D =
metadata_stream_to_writable_bytes(entry[key])
>>>>>> +                    entry[key] =3D =
metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
>>>>>>               if cb is not None:
>>>>>>                   cb(entry)
>>>>>>               else:
>>>>>> @@ -1718,7 +1742,7 @@ class P4UserMap:
>>>>>>               # python2 or python3. To support
>>>>>>               # git-p4.metadataDecodingStrategy=3Dfallback, =
self.users dict values
>>>>>>               # are always bytes, ready to be written to git.
>>>>>> -            emailbytes =3D =
metadata_stream_to_writable_bytes(output["Email"])
>>>>>> +            emailbytes =3D =
metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"])
>>>>>>               self.users[output["User"]] =3D output["FullName"] + =
b" <" + emailbytes + b">"
>>>>>>               self.emails[output["Email"]] =3D output["User"]
>>>>>>   @@ -1730,12 +1754,12 @@ class P4UserMap:
>>>>>>                   fullname =3D mapUser[0][1]
>>>>>>                   email =3D mapUser[0][2]
>>>>>>                   fulluser =3D fullname + " <" + email + ">"
>>>>>> -                self.users[user] =3D =
metadata_stream_to_writable_bytes(fulluser)
>>>>>> +                self.users[user] =3D =
metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
>>>>>>                   self.emails[email] =3D user
>>>>>>             s =3D b''
>>>>>>           for (key, val) in self.users.items():
>>>>>> -            keybytes =3D metadata_stream_to_writable_bytes(key)
>>>>>> +            keybytes =3D =
metadataTranscoder.metadata_stream_to_writable_bytes(key)
>>>>>>               s +=3D b"%s\t%s\n" % (keybytes.expandtabs(1), =
val.expandtabs(1))
>>>>>>             open(self.getUserCacheFilename(), 'wb').write(s)
>>>>>> @@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
>>>>>>           if userid in self.users:
>>>>>>               return self.users[userid]
>>>>>>           else:
>>>>>> -            userid_bytes =3D =
metadata_stream_to_writable_bytes(userid)
>>>>>> +            userid_bytes =3D =
metadataTranscoder.metadata_stream_to_writable_bytes(userid)
>>>>>>               return b"%s <a@b>" % userid_bytes
>>>>>>         def streamTag(self, gitStream, labelName, labelDetails, =
commit, epoch):
>>>>>> @@ -4561,6 +4585,7 @@ commands =3D {
>>>>>>       "unshelve": P4Unshelve,
>>>>>>   }
>>>>>>   +metadataTranscoder =3D =
MetadataTranscoder(defaultMetadataDecodingStrategy, =
defaultFallbackMetadataEncoding)
>>>>>>     def main():
>>>>>>       if len(sys.argv[1:]) =3D=3D 0:
>>>>>> diff --git a/t/meson.build b/t/meson.build
>>>>>> index a59da26be3f..656424fdff3 100644
>>>>>> --- a/t/meson.build
>>>>>> +++ b/t/meson.build
>>>>>> @@ -1090,6 +1090,7 @@ integration_tests =3D [
>>>>>>     't9834-git-p4-file-dir-bug.sh',
>>>>>>     't9835-git-p4-metadata-encoding-python2.sh',
>>>>>>     't9836-git-p4-metadata-encoding-python3.sh',
>>>>>> +  't9837-git-p4-error-encoding.sh',
>>>>>>     't9850-shell.sh',
>>>>>>     't9901-git-web--browse.sh',
>>>>>>     't9902-completion.sh',
>>>>>> diff --git a/t/t9837-git-p4-error-encoding.sh =
b/t/t9837-git-p4-error- encoding.sh
>>>>>> new file mode 100755
>>>>>> index 00000000000..1ea774afb1b
>>>>>> --- /dev/null
>>>>>> +++ b/t/t9837-git-p4-error-encoding.sh
>>>>>> @@ -0,0 +1,53 @@
>>>>>> +#!/bin/sh
>>>>>> +
>>>>>> +test_description=3D'git p4 error encoding
>>>>>> +
>>>>>> +This test checks that the import process handles inconsistent =
text
>>>>>> +encoding in p4 error messages without failing'
>>>>>> +
>>>>>> +. ./lib-git-p4.sh
>>>>>> +
>>>>>> +###############################
>>>>>> +## SECTION REPEATED IN t9835 ##
>>>>>> +###############################
>>>>>> +
>>>>>> +# These tests require Perforce with non-unicode setup.
>>>>>> +out=3D$(2>&1 P4CHARSET=3Dutf8 p4 client -o)
>>>>>> +if test $? -eq 0
>>>>>> +then
>>>>>> +    skip_all=3D"skipping git p4 error encoding tests; Perforce =
is setup with unicode"
>>>>>> +    test_done
>>>>>> +fi
>>>>>> +
>>>>>> +# These tests are specific to Python 3. Write a custom script =
that executes
>>>>>> +# git-p4 directly with the Python 3 interpreter to ensure that =
we use that
>>>>>> +# version even if Git was compiled with Python 2.
>>>>>> +python_target_binary=3D$(which python3)
>>>>>> +if test -n "$python_target_binary"
>>>>>> +then
>>>>>> +    mkdir temp_python
>>>>>> +    PATH=3D"$(pwd)/temp_python:$PATH"
>>>>>> +    export PATH
>>>>>> +
>>>>>> +    write_script temp_python/git-p4-python3 <<-EOF
>>>>>> +    exec "$python_target_binary" "$(git --exec-path)/git-p4" =
"\$@"
>>>>>> +    EOF
>>>>>> +fi
>>>>>> +
>>>>>> +git p4-python3 >err
>>>>>> +if ! grep 'valid commands' err
>>>>>> +then
>>>>>> +    skip_all=3D"skipping python3 git p4 tests; python3 not =
available"
>>>>>> +    test_done
>>>>>> +fi
>>>>>> +
>>>>>> +test_expect_success 'start p4d' '
>>>>>> +    start_p4d
>>>>>> +'
>>>>>> +
>>>>>> +test_expect_success 'see if Perforce error with characters not =
convertable to utf-8 will be processed correctly' '
>>>>>> +    test_when_finished cleanup_git &&
>>>>>> +    $python_target_binary "$TEST_DIRECTORY"/t9837/git-p4-error- =
python3.py "$TEST_DIRECTORY"
>>>>>> +'
>>>>>> +
>>>>>> +test_done
>>>>>> diff --git a/t/t9837/git-p4-error-python3.py =
b/t/t9837/git-p4-error- python3.py
>>>>>> new file mode 100644
>>>>>> index 00000000000..fb65aee386e
>>>>>> --- /dev/null
>>>>>> +++ b/t/t9837/git-p4-error-python3.py
>>>>>> @@ -0,0 +1,15 @@
>>>>>> +import os
>>>>>> +import sys
>>>>>> +from  importlib.machinery import SourceFileLoader
>>>>>> +
>>>>>> +def main():
>>>>>> +    if len(sys.argv[1:]) !=3D 1:
>>>>>> +        print("Expected test directory name")
>>>>>> +
>>>>>> +    gitp4_path =3D sys.argv[1] + "/../git-p4.py"
>>>>>> +    gitp4 =3D SourceFileLoader("gitp4", =
gitp4_path).load_module()
>>>>>> +    gitp4.p4CmdList(["edit", b'\xFEfile'])
>>>>>> +
>>>>>> +if __name__ =3D=3D '__main__':
>>>>>> +    main()
>>>>>> +
>>>>>>=20
>>>>>> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
>>>>=20
>>>=20

