Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C81E3762
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644090; cv=none; b=qexj22+0iw0anPlQGynOsoH2yhnJ0sM4O2xyxW/KI1D+b5xXqR6GE9Aq0T4FCboZbe5HfQvBYeAaueQPSd8uH3E1x+efj1MIi8aB+ReOl5vm0kXME75F34PkyctOn0ArUa+rkjlbJArnu1HGQxZjAU4FpuYaH/Tx9649ZP4VEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644090; c=relaxed/simple;
	bh=DNzBR2/BP64Uct6hjsOx/+nmM76Y9bHd4jdT9IihBkg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=gpQ5HL3/a2xXtqqZ4yr+uWH5wISyG334Kv2//1WxY7YeOktw/KtUOhBdq+6pd/i9fqXUcD4mD0OHohj3Em6xgh8FNIYYCP8K0yoZeV44DqAi2GsB2IkNi2JnbI3LR7gRpVNTyrZXJ4gsW/jw3RFMSl3JI8BhGi91ECQ6O4PER50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK0so3A6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK0so3A6"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47690a4ec97so30151821cf.2
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742644087; x=1743248887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbDL7FHLSKRKSChgxF8X8YtzxJkXVO69RtNE9NP5Y0Y=;
        b=QK0so3A6ZgZp43Ik+jJH6Bfv3xioPyWGdT73TmyGhqkRhb3/5Jvi+0d+KWC9wLQ/yp
         cpFuTNYya83IzHrv0Tm5LD77UpoUL7R9Ab7neoVmWXt2iE8gsxDtFJNcUcj10QrQL4x8
         5TV2DQnQ193HS6Xcm49h0qfuQ0GqTWwrZQppx6jL3h8uUThzg1UBmiQmiCJqZAS4+oqw
         BRiv/kNKoD2+tPje9AqNq6KJFug68enVFnDtZbCZMlqZxpoP2lSEaIPTBiP20FSMgVAG
         KrnFMigSqVip6vni2IG1tyZ8EW8jEVU1zJ7lPigNxoJzKdsmA7BKrFAX9LzMH+WMne63
         IB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644087; x=1743248887;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbDL7FHLSKRKSChgxF8X8YtzxJkXVO69RtNE9NP5Y0Y=;
        b=UFmt6S3M9fwe1p+fYJ/ele3m91hUji9OPpbH23p/gpEpwv7kTgrobYKvy4mRcUxMf0
         A2DoZuGmtlrKtobByHovVAs6KbfSf5M3yIDOBy/mGeMRl68c6YXXTEg8RkQkiicaeS+O
         VjMERRO6PjwxR9kUn39AL96CkvRjQQN6w24TD3sLQFZtrlhlHdF9iXsMaXTTI4CH8hfv
         Y6HJp9ustKOxlT8SJsRy/5dOMisc9+9oVUcNCiBxugpqMRTmiq/KWTcIc+bAVdEjMxVY
         5ehDrxmJ89rjpRLeBMhhW7GxhWz9XQ7w4suUXCH7nr9OQ6mCJBUy9eAOy2R9WUC9p02p
         tUYQ==
X-Gm-Message-State: AOJu0YzyWWQ8XzWGGgH8/vo1Xg9NwbLdubXAee1Qebj5ajlVMH9B35s4
	siZ9hY0U4wNw/PmReC4LW2iL+kFfI3kbKy+3Wtf6BNL5cDs8Rro1iOblSA==
X-Gm-Gg: ASbGnctbaMoVnb0XfzcXZ8MHuvcsBEChu6tyY81ah/aYjcGwA0S/D47J4WGdw/t2srf
	9RwSKNHH2db3uUGZ8IX4TRK1Ezj5pJftVgLtx/3K7xw5PGx/iOz03GMIOTm7j270+y1FAQZhLD1
	DWBsKb3DXTkSXna4XVFZFJ9pTyICTxjuJqWnObSxf7AXVr07DWfkY6+12cVem7DIFHegW5uTUf1
	R2tZAWGGATw9zHGuoYpFj/kfvBGwYhGflQo0zbudhdQnwP/l3miSNunMaT9gaRWsWfTZOKkZ5sS
	wuC0nHbDi6pmt5LGcFxfWy5qLU2PwQhB9IhaH5Byxn8co/CLWV7q+wi6K8tnEK90Iliffe24Y9X
	UfvW74UFRu8Yvd3C9I+AdQQ==
X-Google-Smtp-Source: AGHT+IG58sGUU5pQomQHz1Ylybn+4gt8Z812FwLCNnwAhqyg7k+d3Rc5TJRjuisBg1VWRZ1wWrXfKw==
X-Received: by 2002:a05:622a:40ce:b0:467:5da6:8096 with SMTP id d75a77b69052e-4771de618b9mr110464591cf.44.1742644086769;
        Sat, 22 Mar 2025 04:48:06 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18d535sm22780381cf.39.2025.03.22.04.48.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 04:48:06 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <32b401c3-de0e-427b-83b7-eb5a5b315db1@gmail.com>
Date: Sat, 22 Mar 2025 07:48:05 -0400
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
Content-Language: en-US
In-Reply-To: <pull.1926.git.git.1742440852765.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ping, pretty please? :-)

On 3/19/25 23:20, Nikolay Shustov via GitGitGadget wrote:
> From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
>
> Fixes the git p4 failure happening when Perforce command returns error
> containing byte stream of characters with high bit set. In such situations
> git p4 implementatino fails to decode this byte stream into utf-8 string.
>
> Design:
> Make use of existing decoding fallback strategy, described by
> git-p4.metadataDecodingStrategy and git-p4.metadataFallbackEncoding
> settings in the logic that decodes the Perforce command error bytes.
>
> Details:
> - Moved p4 metadata transcoding logic from
>    metadata_stream_to_writable_bytes(..) into a new MetadataTranscoder class.
> - Enhcanced the implementation to use git-p4.metadataDecodingStrategy and
>    git-p4.metadataFallbackEncoding settings for p4 errors decoding.
> - Added test.
>
> Signed-off-by: Nikolay Shustov <Nikolay.Shustov@gmail.com>
> ---
>      git p4 fix for failure to decode p4 errors
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1926%2Fnshustov%2Fgit-p4-error-decoding-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1926/nshustov/git-p4-error-decoding-v1
> Pull-Request: https://github.com/git/git/pull/1926
>
>   git-p4.py                        | 135 ++++++++++++++++++-------------
>   t/meson.build                    |   1 +
>   t/t9837-git-p4-error-encoding.sh |  53 ++++++++++++
>   t/t9837/git-p4-error-python3.py  |  15 ++++
>   4 files changed, 149 insertions(+), 55 deletions(-)
>   create mode 100755 t/t9837-git-p4-error-encoding.sh
>   create mode 100644 t/t9837/git-p4-error-python3.py
>
> diff --git a/git-p4.py b/git-p4.py
> index c0ca7becaf4..72a4c55f99e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -234,67 +234,91 @@ else:
>   
>   
>   class MetadataDecodingException(Exception):
> -    def __init__(self, input_string):
> +    def __init__(self, input_string, error=None):
>           self.input_string = input_string
> +        self.error = error
>   
>       def __str__(self):
> -        return """Decoding perforce metadata failed!
> +        message = """Decoding perforce metadata failed!
>   The failing string was:
>   ---
>   {}
>   ---
>   Consider setting the git-p4.metadataDecodingStrategy config option to
>   'fallback', to allow metadata to be decoded using a fallback encoding,
> -defaulting to cp1252.""".format(self.input_string)
> +defaulting to cp1252."""
> +        if verbose and self.error is not None:
> +            message += """
> +---
> +Error:
> +---
> +{}"""
> +        return message.format(self.input_string, self.error)
>   
>   
> -encoding_fallback_warning_issued = False
> -encoding_escape_warning_issued = False
> -def metadata_stream_to_writable_bytes(s):
> -    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or defaultMetadataDecodingStrategy
> -    fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') or defaultFallbackMetadataEncoding
> -    if not isinstance(s, bytes):
> -        return s.encode('utf_8')
> -    if encodingStrategy == 'passthrough':
> -        return s
> -    try:
> -        s.decode('utf_8')
> -        return s
> -    except UnicodeDecodeError:
> -        if encodingStrategy == 'fallback' and fallbackEncoding:
> -            global encoding_fallback_warning_issued
> -            global encoding_escape_warning_issued
> -            try:
> -                if not encoding_fallback_warning_issued:
> -                    print("\nCould not decode value as utf-8; using configured fallback encoding %s: %s" % (fallbackEncoding, s))
> -                    print("\n(this warning is only displayed once during an import)")
> -                    encoding_fallback_warning_issued = True
> -                return s.decode(fallbackEncoding).encode('utf_8')
> -            except Exception as exc:
> -                if not encoding_escape_warning_issued:
> -                    print("\nCould not decode value with configured fallback encoding %s; escaping bytes over 127: %s" % (fallbackEncoding, s))
> -                    print("\n(this warning is only displayed once during an import)")
> -                    encoding_escape_warning_issued = True
> -                escaped_bytes = b''
> -                # bytes and strings work very differently in python2 vs python3...
> -                if str is bytes:
> -                    for byte in s:
> -                        byte_number = struct.unpack('>B', byte)[0]
> -                        if byte_number > 127:
> -                            escaped_bytes += b'%'
> -                            escaped_bytes += hex(byte_number)[2:].upper()
> -                        else:
> -                            escaped_bytes += byte
> -                else:
> -                    for byte_number in s:
> -                        if byte_number > 127:
> -                            escaped_bytes += b'%'
> -                            escaped_bytes += hex(byte_number).upper().encode()[2:]
> -                        else:
> -                            escaped_bytes += bytes([byte_number])
> -                return escaped_bytes
> +class MetadataTranscoder:
> +    def __init__(self, default_metadata_decoding_strategy, default_fallback_metadata_encoding):
> +        self.decoding_fallback_warning_issued = False
> +        self.decoding_escape_warning_issued = False
> +        self.decodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or default_metadata_decoding_strategy
> +        self.fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') or default_fallback_metadata_encoding
> +
> +    def decode_metadata(self, s, error_from_fallback=True):
> +        try:
> +            return [s.decode('utf_8'), 'utf_8']
> +        except UnicodeDecodeError as decode_exception:
> +            error = decode_exception
> +            if self.decodingStrategy == 'fallback' and self.fallbackEncoding:
> +                try:
> +                    if not self.decoding_fallback_warning_issued:
> +                        print("\nCould not decode value as utf-8; using configured fallback encoding %s: %s" % (self.fallbackEncoding, s))
> +                        print("\n(this warning is only displayed once during an import)")
> +                        self.decoding_fallback_warning_issued = True
> +                    return [s.decode(self.fallbackEncoding), self.fallbackEncoding]
> +                except Exception as decode_exception:
> +                    if not error_from_fallback:
> +                        return [s, None]
> +                    error = decode_exception
> +            raise MetadataDecodingException(s, error)
> +
> +    def metadata_stream_to_writable_bytes(self, s):
> +        if not isinstance(s, bytes):
> +            return s.encode('utf_8')
> +        if self.decodingStrategy == 'passthrough':
> +            return s
> +
> +        [text, encoding] = self.decode_metadata(s, False)
> +        if encoding == 'utf_8':
> +            # s is of utf-8 already
> +            return s
> +
> +        if encoding is None:
> +            # could not decode s, even with fallback encoding
> +            if not self.decoding_escape_warning_issued:
> +                print("\nCould not decode value with configured fallback encoding %s; escaping bytes over 127: %s" % (self.fallbackEncoding, s))
> +                print("\n(this warning is only displayed once during an import)")
> +                self.decoding_escape_warning_issued = True
> +            escaped_bytes = b''
> +            # bytes and strings work very differently in python2 vs python3...
> +            if str is bytes:
> +                for byte in s:
> +                    byte_number = struct.unpack('>B', byte)[0]
> +                    if byte_number > 127:
> +                        escaped_bytes += b'%'
> +                        escaped_bytes += hex(byte_number)[2:].upper()
> +                    else:
> +                        escaped_bytes += byte
> +            else:
> +                for byte_number in s:
> +                    if byte_number > 127:
> +                        escaped_bytes += b'%'
> +                        escaped_bytes += hex(byte_number).upper().encode()[2:]
> +                    else:
> +                        escaped_bytes += bytes([byte_number])
> +            return escaped_bytes
>   
> -        raise MetadataDecodingException(s)
> +        # were able to decode but not to utf-8
> +        return text.encode('utf_8')
>   
>   
>   def decode_path(path):
> @@ -898,14 +922,14 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>                       decoded_entry[key] = value
>                   # Parse out data if it's an error response
>                   if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
> -                    decoded_entry['data'] = decoded_entry['data'].decode()
> +                    decoded_entry['data'] = metadataTranscoder.decode_metadata(decoded_entry['data'])
>                   entry = decoded_entry
>               if skip_info:
>                   if 'code' in entry and entry['code'] == 'info':
>                       continue
>               for key in p4KeysContainingNonUtf8Chars():
>                   if key in entry:
> -                    entry[key] = metadata_stream_to_writable_bytes(entry[key])
> +                    entry[key] = metadataTranscoder.metadata_stream_to_writable_bytes(entry[key])
>               if cb is not None:
>                   cb(entry)
>               else:
> @@ -1718,7 +1742,7 @@ class P4UserMap:
>               # python2 or python3. To support
>               # git-p4.metadataDecodingStrategy=fallback, self.users dict values
>               # are always bytes, ready to be written to git.
> -            emailbytes = metadata_stream_to_writable_bytes(output["Email"])
> +            emailbytes = metadataTranscoder.metadata_stream_to_writable_bytes(output["Email"])
>               self.users[output["User"]] = output["FullName"] + b" <" + emailbytes + b">"
>               self.emails[output["Email"]] = output["User"]
>   
> @@ -1730,12 +1754,12 @@ class P4UserMap:
>                   fullname = mapUser[0][1]
>                   email = mapUser[0][2]
>                   fulluser = fullname + " <" + email + ">"
> -                self.users[user] = metadata_stream_to_writable_bytes(fulluser)
> +                self.users[user] = metadataTranscoder.metadata_stream_to_writable_bytes(fulluser)
>                   self.emails[email] = user
>   
>           s = b''
>           for (key, val) in self.users.items():
> -            keybytes = metadata_stream_to_writable_bytes(key)
> +            keybytes = metadataTranscoder.metadata_stream_to_writable_bytes(key)
>               s += b"%s\t%s\n" % (keybytes.expandtabs(1), val.expandtabs(1))
>   
>           open(self.getUserCacheFilename(), 'wb').write(s)
> @@ -3349,7 +3373,7 @@ class P4Sync(Command, P4UserMap):
>           if userid in self.users:
>               return self.users[userid]
>           else:
> -            userid_bytes = metadata_stream_to_writable_bytes(userid)
> +            userid_bytes = metadataTranscoder.metadata_stream_to_writable_bytes(userid)
>               return b"%s <a@b>" % userid_bytes
>   
>       def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
> @@ -4561,6 +4585,7 @@ commands = {
>       "unshelve": P4Unshelve,
>   }
>   
> +metadataTranscoder = MetadataTranscoder(defaultMetadataDecodingStrategy, defaultFallbackMetadataEncoding)
>   
>   def main():
>       if len(sys.argv[1:]) == 0:
> diff --git a/t/meson.build b/t/meson.build
> index a59da26be3f..656424fdff3 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1090,6 +1090,7 @@ integration_tests = [
>     't9834-git-p4-file-dir-bug.sh',
>     't9835-git-p4-metadata-encoding-python2.sh',
>     't9836-git-p4-metadata-encoding-python3.sh',
> +  't9837-git-p4-error-encoding.sh',
>     't9850-shell.sh',
>     't9901-git-web--browse.sh',
>     't9902-completion.sh',
> diff --git a/t/t9837-git-p4-error-encoding.sh b/t/t9837-git-p4-error-encoding.sh
> new file mode 100755
> index 00000000000..1ea774afb1b
> --- /dev/null
> +++ b/t/t9837-git-p4-error-encoding.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='git p4 error encoding
> +
> +This test checks that the import process handles inconsistent text
> +encoding in p4 error messages without failing'
> +
> +. ./lib-git-p4.sh
> +
> +###############################
> +## SECTION REPEATED IN t9835 ##
> +###############################
> +
> +# These tests require Perforce with non-unicode setup.
> +out=$(2>&1 P4CHARSET=utf8 p4 client -o)
> +if test $? -eq 0
> +then
> +	skip_all="skipping git p4 error encoding tests; Perforce is setup with unicode"
> +	test_done
> +fi
> +
> +# These tests are specific to Python 3. Write a custom script that executes
> +# git-p4 directly with the Python 3 interpreter to ensure that we use that
> +# version even if Git was compiled with Python 2.
> +python_target_binary=$(which python3)
> +if test -n "$python_target_binary"
> +then
> +	mkdir temp_python
> +	PATH="$(pwd)/temp_python:$PATH"
> +	export PATH
> +
> +	write_script temp_python/git-p4-python3 <<-EOF
> +	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
> +	EOF
> +fi
> +
> +git p4-python3 >err
> +if ! grep 'valid commands' err
> +then
> +	skip_all="skipping python3 git p4 tests; python3 not available"
> +	test_done
> +fi
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'see if Perforce error with characters not convertable to utf-8 will be processed correctly' '
> +	test_when_finished cleanup_git &&
> +	$python_target_binary "$TEST_DIRECTORY"/t9837/git-p4-error-python3.py "$TEST_DIRECTORY"
> +'
> +
> +test_done
> diff --git a/t/t9837/git-p4-error-python3.py b/t/t9837/git-p4-error-python3.py
> new file mode 100644
> index 00000000000..fb65aee386e
> --- /dev/null
> +++ b/t/t9837/git-p4-error-python3.py
> @@ -0,0 +1,15 @@
> +import os
> +import sys
> +from  importlib.machinery import SourceFileLoader
> +
> +def main():
> +    if len(sys.argv[1:]) != 1:
> +        print("Expected test directory name")
> +
> +    gitp4_path = sys.argv[1] + "/../git-p4.py"
> +    gitp4 = SourceFileLoader("gitp4", gitp4_path).load_module()
> +    gitp4.p4CmdList(["edit", b'\xFEfile'])
> +
> +if __name__ == '__main__':
> +    main()
> +
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
