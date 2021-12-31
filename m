Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04912C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 08:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLaIrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 03:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaIrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 03:47:41 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B3CC061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 00:47:41 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id 9so3821306ill.9
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q1sHyYIrC32N3NdW8OJ7Mv8Kzos4vgPR+IjnKiPXtQE=;
        b=CKIOK9qEElg8adBVD+LMyznn85i6rQKYBzEYtYmQ1iZ2EN27j3jBmXiILSqxyObLAy
         lVQ/RfFbPkxWPNeYmbwP6ejuXz+Enag4KHMXQIUKclEJ6vMfQBpkHvNOi6/PGCWAfPkc
         0+vOsOJUHparhCZat5UeLihNVv1SvUsiJjo60WyMcySEmbIREqdtl74QRg0tcxUwlxnK
         3mM86fxtVmI/+RzKolu4S9oWzXd8tCGKdSWrZlcvDqnetN2/BVeOPCvC/bS2TX/TSw77
         Q8uc/68JDp8Y5xaP5SkvSr5dClp/OuXgRVSjcLh5X1dNVYIK8eymoRlnvHhmO4LwGQyK
         X6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=q1sHyYIrC32N3NdW8OJ7Mv8Kzos4vgPR+IjnKiPXtQE=;
        b=VsXJE0ZoHBhtrUlxjHAcwaccHH+RXovJAUgbV46NJ/4mszDiWZgL05VLxtjHCMWtj8
         61ksSIR9UQZep7LWfV3Wl7NrAFgA+t+Jbwi40pklrd52gVCd6Rf5CYYUqHDts5ZhHJPL
         6FffZXITITNjoeQFTbgTUmjJxKhzD2yANDk8bjRgHOUerFWHneOToIQxEegvABKxFJO4
         GGqP3NylnZtqaSBYQxhpLlfAVUEzmYjutfqSToMRbOrX99/ui8BvFu1ZSDIeWGPg80+0
         H7COhV8PCRydPBrNfocwsb+l3oryfOZIgg8s8mq8PAyIN21Vi4vKMoDFmZuqDWWEuULv
         XfPg==
X-Gm-Message-State: AOAM531OWLsUERnm2XchirSt1f5VcuT8amzHvwKFYQVXfz8h+Cw4cMvT
        fmDk6c7er85hw5xXeK4LKTSYOzDFdneBEak0fb4=
X-Google-Smtp-Source: ABdhPJyy4O2eKAMNUUonFVi5N1bYKm7lDD/xX2uJHiYdwNNROuHksERHDsg+onbuurh+3HS6d5HFHH+uW4QJWZQbpLA=
X-Received: by 2002:a05:6e02:178f:: with SMTP id y15mr15633701ilu.235.1640940460640;
 Fri, 31 Dec 2021 00:47:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHo1AWxzPsnLuT8JRWovtaRrGvRS8+0NyucU5K8VEnaL1xxW3Q@mail.gmail.com>
 <Yc4YKG+taXOuf6Kx@camp.crustytoothpaste.net>
In-Reply-To: <Yc4YKG+taXOuf6Kx@camp.crustytoothpaste.net>
From:   Jean-Louis FLOQUET <jese.jlf@gmail.com>
Date:   Fri, 31 Dec 2021 09:47:30 +0100
Message-ID: <CAHo1AWwC325etDTgwWvKLojrCnETjr_xPHTSVBi5RD_XH1uCsg@mail.gmail.com>
Subject: Re: [Question] : git 2.33.1 asks every time password
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jean-Louis FLOQUET <jese.jlf@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

Thanks for your answer.
I'm the maintainer of the server (I'm definitely NOT an expert with
crypto/keys/etc); I use GitBlit 1.9.1. (latest available version).
I have generated the keys (private & public) some years ago, but I
don't know how to create new keys with more recent algorithm.
Please find the output from "ssh -vvv <ip> - p <port>". Please also
note that the "known_hosts2" file doesn't exist (the one without the
"2" exists)

Best regards,
JL

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ ssh -vvv <ip> -p <port>
OpenSSH_8.8p1, OpenSSL 1.1.1l  24 Aug 2021
debug1: Reading configuration data
/c/Users/user/AppData/Roaming/SPB_Data/.ssh/config
debug1: /c/Users/user/AppData/Roaming/SPB_Data/.ssh/config line 3:
Applying options for *
debug1: Reading configuration data /etc/ssh/ssh_config
debug2: resolve_canonicalize: hostname <ip> is address
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts' ->
'/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts'
debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts2' ->
'/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts2'
debug3: ssh_connect_direct: entering
debug1: Connecting to <ip> [<ip>] port <port>.
debug3: set_sock_tos: set socket 4 IP_TOS 0x48
debug1: Connection established.
debug1: identity file /path_to_rsa_key type 0
debug1: identity file /path_to_rsa_key-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_8.8
debug1: Remote protocol version 2.0, remote software version
Gitblit_v1.9.1 (SSHD-CORE-1.2.0-NIO2)
debug1: compat_banner: no match: Gitblit_v1.9.1 (SSHD-CORE-1.2.0-NIO2)
debug2: fd 4 setting O_NONBLOCK
debug1: Authenticating to <ip>:<port> as 'user'
debug3: put_host_port: [<ip>]:<port>
debug3: record_hostkey: found key type DSA in file
/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts:1
debug3: load_hostkeys_file: loaded 1 keys from [<ip>]:<port>
debug1: load_hostkeys: fopen
/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts2: No such file
or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file
or directory
debug3: order_hostkeyalgs: prefer hostkeyalgs: ssh-dss
debug3: send packet: type 20
debug1: SSH2_MSG_KEXINIT sent
debug3: receive packet: type 20
debug1: SSH2_MSG_KEXINIT received
debug2: local client KEXINIT proposal
debug2: KEX algorithms:
curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2=
-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-he=
llman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-s=
ha256,ext-info-c
debug2: host key algorithms:
ssh-dss,ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@opens=
sh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v0=
1@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,sk-ecdsa-sha2-nistp256-ce=
rt-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@=
openssh.com,ssh-ed25519,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-=
nistp521,sk-ssh-ed25519@openssh.com,sk-ecdsa-sha2-nistp256@openssh.com,rsa-=
sha2-512,rsa-sha2-256
debug2: ciphers ctos:
chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@o=
penssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,aes256-cbc,aes192-cbc
debug2: ciphers stoc:
chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@o=
penssh.com,aes256-gcm@openssh.com,aes128-cbc,3des-cbc,aes256-cbc,aes192-cbc
debug2: MACs ctos:
umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.=
com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh=
.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc:
umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.=
com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh=
.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com,zlib
debug2: compression stoc: none,zlib@openssh.com,zlib
debug2: languages ctos:
debug2: languages stoc:
debug2: first_kex_follows 0
debug2: reserved 0
debug2: peer server KEXINIT proposal
debug2: KEX algorithms:
ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-gro=
up-exchange-sha256,diffie-hellman-group-exchange-sha1,diffie-hellman-group1=
4-sha1,diffie-hellman-group1-sha1
debug2: host key algorithms: ssh-rsa,ssh-dss
debug2: ciphers ctos:
aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-cbc,3des-cbc,=
blowfish-cbc,aes192-cbc,aes256-cbc
debug2: ciphers stoc:
aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-cbc,3des-cbc,=
blowfish-cbc,aes192-cbc,aes256-cbc
debug2: MACs ctos:
hmac-md5,hmac-sha1,hmac-sha2-256,hmac-sha2-512,hmac-sha1-96,hmac-md5-96
debug2: MACs stoc:
hmac-md5,hmac-sha1,hmac-sha2-256,hmac-sha2-512,hmac-sha1-96,hmac-md5-96
debug2: compression ctos: none,zlib,zlib@openssh.com
debug2: compression stoc: none,zlib,zlib@openssh.com
debug2: languages ctos:
debug2: languages stoc:
debug2: first_kex_follows 0
debug2: reserved 0
debug1: kex: algorithm: ecdh-sha2-nistp256
debug1: kex: host key algorithm: ssh-dss
debug1: kex: server->client cipher: aes128-ctr MAC: hmac-sha2-256
compression: none
debug1: kex: client->server cipher: aes128-ctr MAC: hmac-sha2-256
compression: none
debug3: send packet: type 30
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug3: receive packet: type 31
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-dss
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
debug3: put_host_port: [<ip>]:<port>
debug3: put_host_port: [<ip>]:<port>
debug3: record_hostkey: found key type DSA in file
/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts:1
debug3: load_hostkeys_file: loaded 1 keys from [<ip>]:<port>
debug1: load_hostkeys: fopen
/c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_hosts2: No such file
or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or dire=
ctory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file
or directory
debug1: Host '[<ip>]:<port>' is known and matches the DSA host key.
debug1: Found key in /c/Users/user/AppData/Roaming/SPB_Data/.ssh/known_host=
s:1
debug3: send packet: type 21
debug2: set_newkeys: mode 1
debug1: rekey out after 4294967296 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug3: receive packet: type 21
debug1: SSH2_MSG_NEWKEYS received
debug2: set_newkeys: mode 0
debug1: rekey in after 4294967296 blocks
debug1: Will attempt key: /path_to_rsa_key RSA
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx explicit
debug2: pubkey_prepare: done
debug3: send packet: type 5
debug3: receive packet: type 6
debug2: service_accept: ssh-userauth
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug3: send packet: type 50
debug3: receive packet: type 51
debug1: Authentications that can continue:
password,keyboard-interactive,publickey
debug3: start over, passed a different list
password,keyboard-interactive,publickey
debug3: preferred publickey,keyboard-interactive,password
debug3: authmethod_lookup publickey
debug3: remaining preferred: keyboard-interactive,password
debug3: authmethod_is_enabled publickey
debug1: Next authentication method: publickey
debug1: Offering public key: /path_to_rsa_key RSA
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx explicit
debug1: send_pubkey_test: no mutual signature algorithm
debug2: we did not send a packet, disable method
debug3: authmethod_lookup keyboard-interactive
debug3: remaining preferred: password
debug3: authmethod_is_enabled keyboard-interactive
debug1: Next authentication method: keyboard-interactive
debug2: userauth_kbdint
debug3: send packet: type 50
debug2: we sent a keyboard-interactive packet, wait for reply
debug3: receive packet: type 60
debug2: input_userauth_info_req: entering
Password authentication
debug2: input_userauth_info_req: num_prompts 1
(user@<ip>) Password:
debug3: send packet: type 61
Connection reset by <ip> port <port>

Le jeu. 30 d=C3=A9c. 2021 =C3=A0 21:35, brian m. carlson
<sandals@crustytoothpaste.net> a =C3=A9crit :
>
> On 2021-12-30 at 15:56:12, Jean-Louis FLOQUET wrote:
> > Hi,
> >
> > I use some scripts to do some batch operations (pull / push), using
> > rsa key and ssh-agent / ssh-add. I'm under Windows 10 (with all
> > updates).
> > When launching my script (see below, truncated : more than 100 repo),
> > I have to enter rsa passphrase (OK) then all push/pull are done
> > without any user interaction (no passphrase, no password, nothing)
> > All Git versions up to 2.33.0.2 are working fine, but since 2.33.1,
> > git asks every time the password.
> > I had to create a 'config' file within '.ssh' directory to support my
> > rsa key (too old format ?). Instructions according to
> > https://stackoverflow.com/questions/35233777/git-error-unable-to-negoti=
ate-with-xx-xx-xxx-xxx-no-matching-host-key-type-fo
>
> If you're seeing this problem, then the system to which you're
> connecting is insecurely configured and using obsolete cryptography.
> You should inform the maintainers of that system of that fact and ask
> them to fix it.
>
> > I also have seen that some people have to add 'ssh-add -K', but it
> > seems to be only for MacOS.
> > According to release notes for 2.33.1, Git Credential Manager for
> > Windows has been replaced by Git Credential Manager Core, but I don't
> > know if it is the "root" problem, and if yes, how to fix my issue.
> > I would greatly appreciate any help / solution. Thanks in advance.
>
> You should run "ssh -vvv SERVER", where SERVER is the server to which
> you're connecting (e.g., git@github.com or whatever) and see what the
> output prints.  That should tell you why it's falling back to a
> password-based configuration.
>
> Note that credential managers are only used for HTTP and HTTPS
> credentials and not for SSH, which is separate.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
