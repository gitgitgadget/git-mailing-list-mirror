Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA81A76AE
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944174; cv=none; b=XPAWatTCOhfcQpebrV3sCuwzM62bZsZpHdXVug2eR/rar32vUf6Pdpc334P1kJqjHscD6CaY0HzLP1lPX7r82sTsMcTpJbTp7D7L3Srtdy4jhQPKJL60ZvawliBAVE65cGd5uZ5MYa74U5amapMmN0DBPRF5/VECuvHWDFzyKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944174; c=relaxed/simple;
	bh=vP6uV3oDJwT9Q2CI5EMsEV9uOu0ciS+D35z6OXu1J7s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=Lv2oASsMUWX3oVtAzvBz5b6hlHsmY5TwLhuEKxUt5zFwNT3Rh6oUOQ6hVla7aItWSYF1VyM710t1dsirqbzHNPjtQEJm8JXX99CEpmErYGuLYuEgqSIajixyzsJpbQ8UIJAfmKM3DBaXI8YX/m96qHJYzr7tchoGG5PPuhAdk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy20nQOF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy20nQOF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774193fdffso39978701cf.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742944171; x=1743548971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M1VPV7vRqW4o0suD+DyXwpZiPIPuluhvz+Nsv+tCzYg=;
        b=Uy20nQOFerQry2zyypvlyp28tlciC/xw6S1vEdsB6acAoDRDmwwHyPuYZmQ7N8+WfI
         0LhUUZ6ig5aS7vue+mMEizoiMzSpmbe2MVgtgyRMdMQLjMcDUuuH6e4Z7EJGLOG2Fzzh
         SvKK3KkwFrQ3uW8tPS96O7JbfX0SCTb9dGuRDt3D+jYCAE98CTf0t/g6U9P5Kv5RWnYk
         xCgoIOYCBYwW4O/gPVuuccViR/YSk6ueSwPVI8QxnseKzhpP80IUOnPsdhkLGrx2Nsn3
         h4HdahSKb8LaGn1WWEXBTtx8rlSsnY/NO9QSORwomhoZUUDmwBACUnRWh6q9UPwyR7AH
         vILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944171; x=1743548971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1VPV7vRqW4o0suD+DyXwpZiPIPuluhvz+Nsv+tCzYg=;
        b=iByaVBTxjcUPvhYZedYiwlh7AuqEaEhLHuJesAVcg9zBQ8L2d9U3cMvh1peVErB0fH
         HFSx61oDmSrWzf1j22Kbal62EgcflVIL0cALSZy84E6+aagdlNIpvFlPhLp51HyAF4xP
         zB01owaikEwFDvwdfKD8xhm3aiwiPkcEQ2MreJ8vH1RWovuXammwI1G7oYtcnIh4d094
         Zii+bce9/mlniIzTQnWBpfNj7eNwD8/a5qyIf+96I3Jnq/cvKDl0lknt4Rc+4JcxNAEr
         mVPW1U0gOED0EPMfaJQGACI8Yc5G34v2uf/F7+tue2btO62POmWE7r5F4rnqBPEWw5Ch
         Y+Hw==
X-Gm-Message-State: AOJu0YxzIy0t6nFS9fOgVOL0GhY5HAbhOBjW/BNagcCkhxz7Iub8JOVQ
	0EhzbLro7Asdp0dSKN0Xmv5507bTHXk0U3C7K+Osl8r9aNstJwzBYMI3jSQ4
X-Gm-Gg: ASbGncvuU3Qzy4hRhTroV2OAoIpG5q8d+TWFpUe+IbYvxPFzNllTTmnWBdAp02wJvPj
	asV1tocywIksWLm487o31VP5f/ZtI8U5ER03t2rTUqwXCJv8Ksear1vp+LcxA3w8tRUa7XsoP0u
	qolQ99lPcejpvrBa/X/NZsEI9XUHM7MxJUNF7ZMXDb5NxxJAfFS6GmVjmcAuiw6apn+N8mUpi77
	ScbLBggMAijtatX9xdl8UGPvQ6F6m8LunHOCt47TI/bhD9hJ8pvzM2Ciz1p3j3HgJmshq8YeO3W
	+w4tAtTIHE6nOZ/MiFWPA7kyNJWEXj1muLHd+dNfwOV9g/LKWzrB/expCgMMM6t3GKg4EsgQKaK
	qjHxPgjV7prRgGrZIe6sQaQ==
X-Google-Smtp-Source: AGHT+IG7OPzqLMehVHx+VZCFdqkChIAs+ILRln8t3us8rrmJg8pSmSI0chlPnoU6ZIudkbsZT2U6yA==
X-Received: by 2002:a05:622a:4897:b0:477:de3:cfab with SMTP id d75a77b69052e-4771de5caffmr297634101cf.32.1742944170517;
        Tue, 25 Mar 2025 16:09:30 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d159a35sm63965891cf.15.2025.03.25.16.09.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:09:29 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <fdbb3f88-7321-4dc0-9ead-7ed9ef0fc995@gmail.com>
Date: Tue, 25 Mar 2025 19:09:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [PATCH] git p4 fix for failure to decode p4 errors
To: git@vger.kernel.org
References: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
 <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
Content-Language: en-US
In-Reply-To: <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think this fix is important.
git-p4 is used in the companies where there is an intent to migrate from 
Perforce to Git and having the issue that this change fixes is a real 
roadblock.
The better we can make git-p4, the more adoption Git would get in the 
commercial world.

On 3/22/25 07:48, Nikolay Shustov wrote:
> ping, pretty please? :-)
>
> On 3/19/25 23:20, Nikolay Shustov via GitGitGadget wrote:
>> From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>>
>> Fixes the git p4 failure happening when Perforce command returns error
>> containing byte stream of characters with high bit set. In such 
>> situations
>> git p4 implementatino fails to decode this byte stream into utf-8 
>> string.
>>
>> Design:
>> Make use of existing decoding fallback strategy, described by
>> git-p4.metadataDecodingStrategy and git-p4.metadataFallbackEncoding
>> settings in the logic that decodes the Perforce command error bytes.
>>
>> Details:
>> - Moved p4 metadata transcoding logic from
>>    metadata_stream_to_writable_bytes(..) into a new 
>> MetadataTranscoder class.
>> - Enhcanced the implementation to use git-p4.metadataDecodingStrategy 
>> and
>>    git-p4.metadataFallbackEncoding settings for p4 errors decoding.
>> - Added test.
>>
>> Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>> ---
>>      git p4 fix for failure to decode p4 errors
>>
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-git-1926/nshustov/git-p4-error-decoding-v1
>> Pull-Request: https://github.com/git/git/pull/1926
>>
>>   git-p4.py                        | 135 ++++++++++++++++++-------------
>>   t/meson.build                    |   1 +
>>   t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
>>   t/t9837/git-p4-error-python3.py  |  15 ++++
>>   4 files changed, 149 insertions(+), 55 deletions(-)
>>   create mode 100755 t/t9837-git-p4-error-encoding.sh
>>   create mode 100644 t/t9837/git-p4-error-python3.py
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index c0ca7becaf4..72a4c55f99e 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -234,67 +234,91 @@ else:
>>       class MetadataDecodingException(Exception):
>> -    def __init__(self, input_string):
>> +    def __init__(self, input_string, error=None):
>>           self.input_string = input_string
>> +        self.error = error
>>         def __str__(self):
>> -        return """Decoding perforce metadata failed!
>> +        message = """Decoding perforce metadata failed!
>>   The failing string was:
>>   ---
>>   {}
>>   ---
>>   Consider setting the git-p4.metadataDecodingStrategy config option to
>>   'fallback', to allow metadata to be decoded using a fallback encoding,
>> -defaulting to cp1252.""".format(self.input_string)
>> +defaulting to cp1252."""
>> +        if verbose and self.error is not None:
>> +            message += """
>> +---
>> +Error:
>> +---
>> +{}"""
>> +        return message.format(self.input_string, self.error)
>>     -encoding_fallback_warning_issued = False
>> -encoding_escape_warning_issued = False
>> -def metadata_stream_to_writable_bytes(s):
>> -    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') 
>> or defaultMetadataDecodingStrategy
>> -    fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') 
>> or defaultFallbackMetadataEncoding
>> -    if not isinstance(s, bytes):
>> -        return s.encode('utf_8')
>> -    if encodingStrategy == 'passthrough':
>> -        return s
>> -    try:
>> -        s.decode('utf_8')
>> -        return s
>> -    except UnicodeDecodeError:
>> -        if encodingStrategy == 'fallback' and fallbackEncoding:
>> -            global encoding_fallback_warning_issued
>> -            global encoding_escape_warning_issued
>> -            try:
>> -                if not encoding_fallback_warning_issued:
>> -                    print("\nCould not decode value as utf-8; using 
>> configured fallback encoding %s: %s" % (fallbackEncoding, s))
>> -                    print("\n(this warning is only displayed once 
>> during an import)")
>> -                    encoding_fallback_warning_issued = True
>> -                return s.decode(fallbackEncoding).encode('utf_8')
>> -            except Exception as exc:
>> -                if not encoding_escape_warning_issued:
>> -                    print("\nCould not decode value with configured 
>> fallback encoding %s; escaping bytes over 127: %s" % 
>> (fallbackEncoding, s))
>> -                    print("\n(this warning is only displayed once 
>> during an import)")
>> -                    encoding_escape_warning_issued = True
>> -                escaped_bytes = b''
>> -                # bytes and strings work very differently in python2 
>> vs python3...
>> -                if str is bytes:
>> -                    for byte in s:
>> -                        byte_number = struct.unpack('>B', byte)[0]
>> -                        if byte_number > 127:
>> -                            escaped_bytes += b'%'
>> -                            escaped_bytes += 
>> hex(byte_number)[2:].upper()
>> -                        else:
>> -                            escaped_bytes += byte
>> -                else:
>> -                    for byte_number in s:
>> -                        if byte_number > 127:
>> -                            escaped_bytes += b'%'
>> -                            escaped_bytes += 
>> hex(byte_number).upper().encode()[2:]
>> -                        else:
>> -                            escaped_bytes += bytes([byte_number])
>> -                return escaped_bytes
>> +class MetadataTranscoder:
>> +    def __init__(self, default_metadata_decoding_strategy, 
>> default_fallback_metadata_encoding):
>> +        self.decoding_fallback_warning_issued = False
>> +        self.decoding_escape_warning_issued = False
>> +        self.decodingStrategy = 
>> gitConfig('git-p4.metadataDecodingStrategy') or 
>> default_metadata_decoding_strategy
>> +        self.fallbackEncoding = 
>> gitConfig('git-p4.metadataFallbackEncoding') or 
>> default_fallback_metadata_encoding
>> +
>> +    def decode_metadata(self, s, error_from_fallback=True):
>> +        try:
>> +            return [s.decode('utf_8'), 'utf_8']
>> +        except UnicodeDecodeError as decode_exception:
>> +            error = decode_exception
>> +            if self.decodingStrategy == 'fallback' and 
>> self.fallbackEncoding:
>> +                try:
>> +                    if not self.decoding_fallback_warning_issued:
>> +                        print("\nCould not decode value as utf-8; 
>> using configured fallback encoding %s: %s" % (self.fallbackEncoding, s))
>> +                        print("\n(this warning is only displayed 
>> once during an import)")
>> +                        self.decoding_fallback_warning_issued = True
>> +                    return [s.decode(self.fallbackEncoding), 
>> self.fallbackEncoding]
>> +                except Exception as decode_exception:
>> +                    if not error_from_fallback:
>> +                        return [s, None]
>> +                    error = decode_exception
>> +            raise MetadataDecodingException(s, error)
>> +
>> +    def metadata_stream_to_writable_bytes(self, s):
>> +        if not isinstance(s, bytes):
>> +            return s.encode('utf_8')
>> +        if self.decodingStrategy == 'passthrough':
>> +            return s
>> +
>> +        [text, encoding] = self.decode_metadata(s, False)
>> +        if encoding == 'utf_8':
>> +            # s is of utf-8 already
>> +            return s
>> +
>> +        if encoding is None:
>> +            # could not decode s, even with fallback encoding
>> +            if not self.decoding_escape_warning_issued:
>> +                print("\nCould not decode value with configured 
>> fallback encoding %s; escaping bytes over 127: %s" % 
>> (self.fallbackEncoding, s))
>> +                print("\n(this warning is only displayed once during 
>> an import)")
>> +                self.decoding_escape_warning_issued = True
>> +            escaped_bytes = b''
>> +            # bytes and strings work very differently in python2 vs 
>> python3...
>> +            if str is bytes:
>> +                for byte in s:
>> +                    byte_number = struct.unpack('>B', byte)[0]
>> +                    if byte_number > 127:
>> +                        escaped_bytes += b'%'
>> +                        escaped_bytes += hex(byte_number)[2:].upper()
>> +                    else:
>> +                        escaped_bytes += byte
>> +            else:
>> +                for byte_number in s:
>> +                    if byte_number > 127:
>> +                        escaped_bytes += b'%'
>> +                        escaped_bytes += 
>> hex(byte_number).upper().encode()[2:]
>> +                    else:
>> +                        escaped_bytes += bytes([byte_number])
>> +            return escaped_bytes
>>   -        raise MetadataDecodingException(s)
>> +        # were able to decode but not to utf-8
>> +        return text.encode('utf_8')
>>       def decode_path(path):
>> @@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=None, 
>> stdin_mode='w+b', cb=None, skip_info=False,
>>                       decoded_entry[key] = value
>>                   # Parse out data if it's an error response
>>                   if decoded_entry.get('code') == 'error' and 'data' 
>> in decoded_entry:
>> -                    decoded_entry['data'] = 
>> decoded_entry['data'].decode()
>> +                    decoded_entry['data'] = 
>> metadataTranscoder.decode_metadata(decoded_entry['data'])
>>                   entry = decoded_entry
>>               if skip_info:
>>                   if 'code' in entry and entry['code'] == 'info':
>>                       continue
>>               for key in p4KeysContainingNonUtf8Chars():
>>                   if key in entry:
>> -                    entry[key] = 
>> metadata_stream_to_writable_bytes(entry[key])
>> +                    entry[key] = 
>> metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
>>               if cb is not None:
>>                   cb(entry)
>>               else:
>> @@ -1718,7 +1742,7 @@ class P4UserMap:
>>               # python2 or python3. To support
>>               # git-p4.metadataDecodingStrategy=fallback, self.users 
>> dict values
>>               # are always bytes, ready to be written to git.
>> -            emailbytes = 
>> metadata_stream_to_writable_bytes(output["Email"])
>> +            emailbytes = 
>> metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"])
>>               self.users[output["User"]] = output["FullName"] + b" <" 
>> + emailbytes + b">"
>>               self.emails[output["Email"]] = output["User"]
>>   @@ -1730,12 +1754,12 @@ class P4UserMap:
>>                   fullname = mapUser[0][1]
>>                   email = mapUser[0][2]
>>                   fulluser = fullname + " <" + email + ">"
>> -                self.users[user] = 
>> metadata_stream_to_writable_bytes(fulluser)
>> +                self.users[user] = 
>> metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
>>                   self.emails[email] = user
>>             s = b''
>>           for (key, val) in self.users.items():
>> -            keybytes = metadata_stream_to_writable_bytes(key)
>> +            keybytes = 
>> metadataTranscoder.metadata_stream_to_writable_bytes(key)
>>               s += b"%s\t%s\n" % (keybytes.expandtabs(1), 
>> val.expandtabs(1))
>>             open(self.getUserCacheFilename(), 'wb').write(s)
>> @@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
>>           if userid in self.users:
>>               return self.users[userid]
>>           else:
>> -            userid_bytes = metadata_stream_to_writable_bytes(userid)
>> +            userid_bytes = 
>> metadataTranscoder.metadata_stream_to_writable_bytes(userid)
>>               return b"%s <a@b>" % userid_bytes
>>         def streamTag(self, gitStream, labelName, labelDetails, 
>> commit, epoch):
>> @@ -4561,6 +4585,7 @@ commands = {
>>       "unshelve": P4Unshelve,
>>   }
>>   +metadataTranscoder = 
>> MetadataTranscoder(defaultMetadataDecodingStrategy, 
>> defaultFallbackMetadataEncoding)
>>     def main():
>>       if len(sys.argv[1:]) == 0:
>> diff --git a/t/meson.build b/t/meson.build
>> index a59da26be3f..656424fdff3 100644
>> --- a/t/meson.build
>> +++ b/t/meson.build
>> @@ -1090,6 +1090,7 @@ integration_tests = [
>>     't9834-git-p4-file-dir-bug.sh',
>>     't9835-git-p4-metadata-encoding-python2.sh',
>>     't9836-git-p4-metadata-encoding-python3.sh',
>> +  't9837-git-p4-error-encoding.sh',
>>     't9850-shell.sh',
>>     't9901-git-web--browse.sh',
>>     't9902-completion.sh',
>> diff --git a/t/t9837-git-p4-error-encoding.sh 
>> b/t/t9837-git-p4-error-encoding.sh
>> new file mode 100755
>> index 00000000000..1ea774afb1b
>> --- /dev/null
>> +++ b/t/t9837-git-p4-error-encoding.sh
>> @@ -0,0 +1,53 @@
>> +#!/bin/sh
>> +
>> +test_description='git p4 error encoding
>> +
>> +This test checks that the import process handles inconsistent text
>> +encoding in p4 error messages without failing'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +###############################
>> +## SECTION REPEATED IN t9835 ##
>> +###############################
>> +
>> +# These tests require Perforce with non-unicode setup.
>> +out=$(2>&1 P4CHARSET=utf8 p4 client -o)
>> +if test $? -eq 0
>> +then
>> +    skip_all="skipping git p4 error encoding tests; Perforce is 
>> setup with unicode"
>> +    test_done
>> +fi
>> +
>> +# These tests are specific to Python 3. Write a custom script that 
>> executes
>> +# git-p4 directly with the Python 3 interpreter to ensure that we 
>> use that
>> +# version even if Git was compiled with Python 2.
>> +python_target_binary=$(which python3)
>> +if test -n "$python_target_binary"
>> +then
>> +    mkdir temp_python
>> +    PATH="$(pwd)/temp_python:$PATH"
>> +    export PATH
>> +
>> +    write_script temp_python/git-p4-python3 <<-EOF
>> +    exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
>> +    EOF
>> +fi
>> +
>> +git p4-python3 >err
>> +if ! grep 'valid commands' err
>> +then
>> +    skip_all="skipping python3 git p4 tests; python3 not available"
>> +    test_done
>> +fi
>> +
>> +test_expect_success 'start p4d' '
>> +    start_p4d
>> +'
>> +
>> +test_expect_success 'see if Perforce error with characters not 
>> convertable to utf-8 will be processed correctly' '
>> +    test_when_finished cleanup_git &&
>> +    $python_target_binary 
>> "$TEST_DIRECTORY"/t9837/git-p4-error-python3.py "$TEST_DIRECTORY"
>> +'
>> +
>> +test_done
>> diff --git a/t/t9837/git-p4-error-python3.py 
>> b/t/t9837/git-p4-error-python3.py
>> new file mode 100644
>> index 00000000000..fb65aee386e
>> --- /dev/null
>> +++ b/t/t9837/git-p4-error-python3.py
>> @@ -0,0 +1,15 @@
>> +import os
>> +import sys
>> +from  importlib.machinery import SourceFileLoader
>> +
>> +def main():
>> +    if len(sys.argv[1:]) != 1:
>> +        print("Expected test directory name")
>> +
>> +    gitp4_path = sys.argv[1] + "/../git-p4.py"
>> +    gitp4 = SourceFileLoader("gitp4", gitp4_path).load_module()
>> +    gitp4.p4CmdList(["edit", b'\xFEfile'])
>> +
>> +if __name__ == '__main__':
>> +    main()
>> +
>>
>> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
